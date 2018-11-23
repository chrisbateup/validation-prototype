{-# LANGUAGE RankNTypes #-}

module Web.ConsumerData.Au.Api.Types.Banking.ProductsGens where

import           Control.Monad.Catch (MonadThrow)
import           Data.Text           (Text)
import           Data.Time.Gens      (utcTimeGen)
import           Hedgehog            (MonadGen)
import qualified Hedgehog.Gen        as Gen
import qualified Hedgehog.Range      as Range
import           Text.URI.Gens       (genURI)

import Web.ConsumerData.Au.Api.Types
-- import Web.ConsumerData.Au.Api.Types.Banking.Common.ProductDetail
-- import Web.ConsumerData.Au.Api.Types.Banking.Gens
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.Constraint
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.DepositRate
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.Discount
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.Eligibility
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.Feature
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.Fee
import Web.ConsumerData.Au.Api.Types.Banking.ProductAccountComponents.Product.LendingRate


-- asciiStringGen :: Gen AsciiString
asciiStringGen :: (MonadGen m) => m AsciiString
asciiStringGen = AsciiString
  <$> Gen.text (Range.linear 5 20) Gen.ascii

-- amountStringGen :: Gen AmountString
amountStringGen :: (MonadGen m) => m AmountString
amountStringGen = AmountString
  <$> Gen.text (Range.linear 5 20) Gen.unicode


-- currencyStringGen :: Gen CurrencyString
currencyStringGen :: (MonadGen m) => m CurrencyString
currencyStringGen = CurrencyString
  <$> Gen.text (Range.linear 5 20) Gen.unicode

-- currencyStringGen :: Gen CurrencyString
dateTimeStringGen :: (MonadGen m) => m DateTimeString
dateTimeStringGen = Gen.lift $ DateTimeString
  <$> utcTimeGen

-- durationStringGen :: Gen DurationString
durationStringGen :: (MonadGen m) => m DurationString
durationStringGen = DurationString
  <$> Gen.text (Range.linear 5 20) Gen.unicode

-- intGen :: Gen Int
intGen :: (MonadGen m) => m Int
intGen = Gen.int (Range.linear 0 maxBound)


-- rateStringGen :: Gen RateString
rateStringGen :: (MonadGen m) => m RateString
rateStringGen = RateString
  <$> Gen.text (Range.linear 5 20) Gen.unicode

textGen :: (MonadGen m) => m Text
textGen = Gen.text (Range.linear 5 20) Gen.unicode


-- genURI :: Gen URI
-- genURI =
--   -- _todo
--   genURI


-- productGen :: Gen Product
productGen :: forall m. (MonadGen m, MonadThrow m) => m Product
productGen  = Product
  <$> asciiStringGen
  <*> Gen.maybe dateTimeStringGen
  <*> Gen.maybe dateTimeStringGen
  <*> dateTimeStringGen
  <*> productCategoryGen
  <*> textGen
  <*> textGen
  <*> textGen
  <*> Gen.maybe textGen
  <*> Gen.maybe genURI
  <*> Gen.bool_
  <*> Gen.maybe productAdditionalInformationGen

-- productAdditionalInformationGen :: Gen ProductAdditionalInformation
productAdditionalInformationGen :: (MonadGen m, MonadThrow m) => m ProductAdditionalInformation
productAdditionalInformationGen = ProductAdditionalInformation
  <$> Gen.maybe genURI
  <*> Gen.maybe genURI
  <*> Gen.maybe genURI
  <*> Gen.maybe genURI
  <*> Gen.maybe genURI

-- productCategoryGen :: Gen ProductCategory
productCategoryGen :: (MonadGen m) => m ProductCategory
productCategoryGen = Gen.element
  [ PCPersAtCallDeposits
  , PCBusAtCallDeposits
  , PCTermDeposits
  , PCResidential_mortgages
  , PCPersCredAndChrgCards
  , PCBusCredAndChrgCards
  , PCPersLoans
  , PCPersLeasing
  , PCBusLeasing
  , PCTradeFinance
  , PCPersOverdraft
  , PCBusOverdraft
  , PCBusLoans
  , PCForeignCurrAtCallDeposits
  , PCForeignCurrTermDeposits
  , PCForeignCurrLoan
  , PCForeignCurrrenctOverdraft
  , PCTravelCard
  ]

-- #######################################

-- productDetailGen :: Gen ProductDetail
productDetailGen :: (MonadGen m, MonadThrow m) => m ProductDetail
productDetailGen = ProductDetail
  -- <$> Gen.maybe productGen
  <$> productGen
  -- <*> Gen.maybe productBundlesGen
  -- <*> Gen.maybe productFeaturesGen
  -- <*> Gen.maybe productConstraintsGen
  -- <*> Gen.maybe productEligibilitiesGen
  -- <*> Gen.maybe productFeesGen
  -- <*> Gen.maybe productDepositRatesGen
  -- <*> Gen.maybe productLendingRatesGen
  -- <*> Gen.maybe productRepaymentTypeGen

-- productBundlesGen :: Gen ProductBundles
productBundlesGen :: (MonadGen m, MonadThrow m) => m ProductBundles
productBundlesGen = ProductBundles
  <$> Gen.list (Range.linear 0 10) productBundleGen

-- productBundleGen :: Gen ProductBundle
productBundleGen :: (MonadGen m, MonadThrow m) => m ProductBundle
productBundleGen = ProductBundle
  <$> textGen
  <*> textGen
  <*> Gen.maybe genURI
  <*> Gen.list (Range.linear 0 10) textGen

-- productRepaymentTypeGen :: Gen ProductRepaymentType
productRepaymentTypeGen :: (MonadGen m) => m ProductRepaymentType
productRepaymentTypeGen = Gen.element
  [ PRepaymentTypeInterestOnly
  , PRepaymentTypePrincipalAndInterest
  , PRepaymentTypeNegotiable
  ]

-- #######################################

-- productConstraintsGen :: Gen ProductConstraints
productConstraintsGen :: (MonadGen m) => m ProductConstraints
productConstraintsGen = ProductConstraints
  <$> Gen.list (Range.linear 0 10) productConstraintGen

-- productConstraintGen :: Gen ProductConstraint
productConstraintGen :: (MonadGen m) => m ProductConstraint
productConstraintGen = Gen.lift $ Gen.choice
  [ PConstraintMinBalance <$> amountStringGen
  , PConstraintOpeningBalance <$> amountStringGen
  , PConstraintMaxLimit <$> amountStringGen
  , PConstraintMinLimit <$> amountStringGen
  ]

-- #######################################

-- productDepositRatesGen :: Gen ProductDepositRates
productDepositRatesGen :: (MonadGen m, MonadThrow m) => m ProductDepositRates
productDepositRatesGen = ProductDepositRates
  <$> Gen.list (Range.linear 0 10) productDepositRateGen

-- productDepositRateGen :: Gen ProductDepositRate
productDepositRateGen :: (MonadGen m, MonadThrow m) => m ProductDepositRate
productDepositRateGen = ProductDepositRate
  <$> productDepositRateTypeGen
-- WARNING
  <*> rateStringGen
  <*> Gen.maybe textGen
  <*> Gen.maybe genURI

-- productDepositRateTypeGen :: Gen ProductDepositRateType
productDepositRateTypeGen :: (MonadGen m) => m ProductDepositRateType
productDepositRateTypeGen = Gen.lift $ Gen.choice
  [ PDepositRateTypeFixed <$> durationStringGen
  , PDepositRateTypeBonus <$> textGen
  , PDepositRateTypeBundleBonus <$> textGen
  , pure PDepositRateTypeVariable
  , PDepositRateTypeIntroductory <$> durationStringGen
  ]

-- #######################################

-- productDiscountsGen :: Gen ProductDiscounts
productDiscountsGen :: (MonadGen m) => m ProductDiscounts
productDiscountsGen = ProductDiscounts
  <$> Gen.list (Range.linear 0 10) productDiscountGen

-- productDiscountGen :: Gen ProductDiscount
productDiscountGen :: (MonadGen m) => m ProductDiscount
productDiscountGen = ProductDiscount
  <$> textGen
  <*> productDiscountTypeGen
-- WARNING
  <*> amountStringGen

-- productDiscountTypeGen :: Gen ProductDiscountType
productDiscountTypeGen :: (MonadGen m) => m ProductDiscountType
productDiscountTypeGen = Gen.lift $ Gen.choice
  [ PDiscountBalance <$> amountStringGen
  , PDiscountDeposits <$> amountStringGen
  , PDiscountPayments <$> amountStringGen
  , PDiscountBundle <$> textGen
  ]

-- #######################################

-- productEligibilitiesGen :: Gen ProductEligibilities
productEligibilitiesGen :: (MonadGen m, MonadThrow m) => m ProductEligibilities
productEligibilitiesGen = ProductEligibilities
  <$> Gen.list (Range.linear 0 10) productEligibilityGen

-- productEligibilityGen :: Gen ProductEligibility
productEligibilityGen :: (MonadGen m, MonadThrow m) => m ProductEligibility
productEligibilityGen = ProductEligibility
  <$> textGen
  <*> productEligibilityTypeGen
-- WARNING
  <*> Gen.maybe textGen
  <*> Gen.maybe genURI

-- productEligibilityTypeGen :: Gen ProductEligibilityType
productEligibilityTypeGen :: (MonadGen m) => m ProductEligibilityType
productEligibilityTypeGen = Gen.lift $ Gen.choice
  [ pure PEligibilityBusiness
  , pure PEligibilityPensionRecipient
  , PEligibilityMinAge <$> intGen
  , PEligibilityMaxAge <$> intGen
  , PEligibilityMinIncome <$> amountStringGen
  , PEligibilityMinTurnover <$> amountStringGen
  , pure PEligibilityStaff
  , pure PEligibilityStudent
  , PEligibilityEmploymentStatus <$> textGen
  , PEligibilityResidencyStatus <$> textGen
  , PEligibilityOther <$> textGen
  ]

-- #######################################

-- productFeaturesGen :: Gen ProductFeatures
productFeaturesGen :: (MonadGen m) => m ProductFeatures
productFeaturesGen = ProductFeatures
  <$> Gen.list (Range.linear 0 10) productFeatureTypeGen

-- productFeatureTypeGen :: Gen ProductFeatureType
productFeatureTypeGen :: (MonadGen m) => m ProductFeatureType
productFeatureTypeGen = Gen.lift $ Gen.choice
  [ pure PFeatureCardAcess
  , PFeatureAdditionalCards <$> intGen
  , pure PFeatureUnlimitedTxns
  , PFeatureFreeTxns <$> intGen
  , PFeatureFreeTxnsAllowance <$> amountStringGen
  , PFeatureLoyaltyProgram <$> textGen
  , pure PFeatureOffset
  , pure PFeatureOverdraft
  , pure PFeatureRedraw
  , PFeatureInsurance <$> textGen
  , pure PFeatureBalanceTransfers
  , PFeatureInterestFree <$> durationStringGen
  , PFeatureInterestFreeTransfers <$> durationStringGen
  , PFeatureDigitalWallet <$> textGen
  , pure PFeatureDigitalBanking
  , pure PFeatureNppPayid
  , pure PFeatureNppEnabled
  , pure PFeatureDonateInterest
  , PFeatureBillPayment <$> textGen
  ]

-- #######################################

-- productFeesGen :: Gen ProductFees
productFeesGen :: (MonadGen m, MonadThrow m) => m ProductFees
productFeesGen = ProductFees
  <$> Gen.list (Range.linear 0 10) productFeeGen

-- productFeeGen :: Gen ProductFee
productFeeGen :: (MonadGen m, MonadThrow m) => m ProductFee
productFeeGen = ProductFee
  <$> textGen
  <*> productFeeTypeGen
-- WARNING
  <*> Gen.maybe amountStringGen
  <*> Gen.maybe rateStringGen
  <*> Gen.maybe rateStringGen
  <*> Gen.maybe currencyStringGen
  <*> Gen.maybe textGen
  <*> Gen.maybe genURI
  <*> Gen.maybe productDiscountsGen

-- productFeeTypeGen :: Gen ProductFeeType
productFeeTypeGen :: (MonadGen m) => m ProductFeeType
productFeeTypeGen = Gen.lift $ Gen.choice
  [ PFeePeriodicPeriodic <$> durationStringGen
  , PFeePeriodicTransaction <$> textGen
  , pure PFeePeriodicEstablishment
  , pure PFeePeriodicExit
  , pure PFeePeriodicOverdraw
  , PFeePeriodicMinBalance <$> durationStringGen
  , pure PFeePeriodicRedraw
  , pure PFeePeriodicChequeCash
  , pure PFeePeriodicChequeStop
  , pure PFeePeriodicChequeBook
  , pure PFeePeriodicCardReplace
  , pure PFeePeriodicPaperStatement
  , PFeePeriodicOtherEvent <$> textGen
  ]

-- #######################################

-- productLendingRatesGen :: Gen ProductLendingRates
productLendingRatesGen :: (MonadGen m, MonadThrow m) => m ProductLendingRates
productLendingRatesGen = ProductLendingRates
  <$> Gen.list (Range.linear 0 10) productLendingRateGen

-- productLendingRateGen :: Gen ProductLendingRate
productLendingRateGen ::
  -- forall m.
  (MonadGen m, MonadThrow m) => m ProductLendingRate
productLendingRateGen = ProductLendingRate
  <$> productLendingRateTypeGen
-- WARNING
  <*> rateStringGen
  <*> Gen.maybe textGen
  <*> Gen.maybe genURI

-- productLendingRateTypeGen :: Gen ProductLendingRateType
productLendingRateTypeGen :: (MonadGen m) => m ProductLendingRateType
productLendingRateTypeGen = Gen.lift $ Gen.choice
  [ PLendingRateFixed <$> durationStringGen
  , PLendingRateIntroductory <$> durationStringGen
  , PLendingRateDiscount <$> textGen
  , PLendingRatePenalty <$> textGen
  , PLendingRateBundleDiscount <$> textGen
  , PLendingRateFloating <$> textGen
  , PLendingRateMarketLinked <$> textGen
  , pure PLendingRateCashAdvance
  , pure PLendingRateVariable
  , PLendingRateComparison <$> textGen
  ]
