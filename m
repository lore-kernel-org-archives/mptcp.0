Content-Type: multipart/mixed; boundary="===============0353879506719631419=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: default KUNIT_* fragments to
 KUNIT_ALL_TESTS
Date: Fri, 19 Jun 2020 17:25:37 +0200
Message-ID: <b999e02f-3a62-2a4f-4637-877db22db29a@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2006182045190.19717@adhawale-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4753

--===============0353879506719631419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 19/06/2020 05:45, Mat Martineau wrote:
> =

> On Tue, 16 Jun 2020, Matthieu Baerts wrote:
> =

>> This makes it easier to enable all KUnit fragments.
>>
>> Adding 'if !KUNIT_ALL_TESTS so individual tests can not be turned off.
>> Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
>> menuconfig.
>>
>> Similar to beaed42c427d ("kunit: default KUNIT_* fragments to =

>> KUNIT_ALL_TESTS")
>> and following ones.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 to be squashed in "mptcp: move crypto test to KUNIT"
>>
>> net/mptcp/Kconfig | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
>> index c701f27300ce..d7d5f9349366 100644
>> --- a/net/mptcp/Kconfig
>> +++ b/net/mptcp/Kconfig
>> @@ -21,9 +21,10 @@ config MPTCP_IPV6
>> endif
>>
>> config MPTCP_KUNIT_TESTS
>> -=C2=A0=C2=A0=C2=A0 tristate "This builds the MPTCP KUnit tests"
>> +=C2=A0=C2=A0=C2=A0 tristate "This builds the MPTCP KUnit tests" if !KUN=
IT_ALL_TESTS
>> =C2=A0=C2=A0=C2=A0=C2=A0select MPTCP
>> =C2=A0=C2=A0=C2=A0=C2=A0depends on KUNIT
>> +=C2=A0=C2=A0=C2=A0 default KUNIT_ALL_TESTS
>> =C2=A0=C2=A0=C2=A0=C2=A0help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Currently covers the MPTCP crypto helpers.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Only useful for kernel devs running KUnit=
 test harness and are not
>> -- =

>> 2.27.0.rc0
> =

> Looks good to me, thanks Matthieu.

Thank you for the review!

Just applied:
- 0868473a09ec: "squashed" in "mptcp: move crypto test to KUNIT"
- e414c4e075c8: "Signed-off-by" + "Co-developed-by"
- fadbf9fd17fc..7c2398e9940d: result

Tests will be launched soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0353879506719631419==--
