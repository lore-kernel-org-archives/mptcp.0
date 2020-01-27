Content-Type: multipart/mixed; boundary="===============3241759639719151708=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: settings: tests can be in subsubdirs
Date: Mon, 27 Jan 2020 17:05:15 +0100
Message-ID: <602ab319-dcb9-4ac7-b2b8-f7b6072ddc03@tessares.net>
In-Reply-To: 201911211018.D6CD68AC5@keescook
X-Status: 
X-Keywords:                  
X-UID: 3525

--===============3241759639719151708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shuah, Kees,

On 21/11/2019 19:52, Kees Cook wrote:
> On Thu, Nov 21, 2019 at 05:32:42PM +0100, Matthieu Baerts wrote:
>> Hi Shuah,
>>
>> First, thank you for maintaining the Kernel Selftest framework!
>>
>> On 22/10/2019 19:12, Matthieu Baerts wrote:
>>> Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
>>> timeout per test) adds support for a new per-test-directory "settings"
>>> file. But this only works for tests not in a sub-subdirectories, e.g.
>>>
>>>    - tools/testing/selftests/rtc (rtc) is OK,
>>>    - tools/testing/selftests/net/mptcp (net/mptcp) is not.
>>>
>>> We have to increase the timeout for net/mptcp tests which are not
>>> upstreamed yet but this fix is valid for other tests if they need to add
>>> a "settings" file, see the full list with:
>>>
>>>     tools/testing/selftests/*/*/**/Makefile
>>>
>>> Note that this patch changes the text header message printed at the end
>>> of the execution but this text is modified only for the tests that are
>>> in sub-subdirectories, e.g.
>>>
>>>     ok 1 selftests: net/mptcp: mptcp_connect.sh
>>>
>>> Before we had:
>>>
>>>     ok 1 selftests: mptcp: mptcp_connect.sh
>>>
>>> But showing the full target name is probably better, just in case a
>>> subsubdir has the same name as another one in another subdirectory.
>>>
>>> Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeo=
ut per test)
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> Sorry to bother you again with this but by chance, did you have a look at
>> the patch below? :)
>>
>> It doesn't only fix an issue with MPTCP, not in the kernel yet. But it a=
lso
>> fixes the issue of taking the right "settings" file (if available) for a=
ny
>> other tests in a sub-directory, e.g.:
>>
>>    drivers/dma-buf
>>    filesystems/binderfs
>>    net/forwarding
>>    networking/timestamping
>>
>> But I guess all tests in powerpc/* dirs and others.
> =

> Thanks for the ping! I missed this patch when you originally sent it.
> Yes, this make sense to me:
> =

> Reviewed-by: Kees Cook <keescook(a)chromium.org>

Kees, Thank you for this review!

Shuah, I am sorry to send you this new request. It is just to inform you =

that the first selftests for MPTCP are now in "net-next" repo, ready for =

the future Linux 5.6.
We would then be very happy to see this patch here below for the =

kselftest framework accepted to avoid timeouts. Locally we apply this =

patch before running the selftests but we cannot ask everybody running =

MPTCP' selftests to do the same :)

> As an improvement on this, I wonder if we need to walk all directories
> between $BASEDIR and $DIR? Actually, let me write this and send it...

Thank you, Kees, for this improvement!

Cheers,
Matt

> =

> -Kees
> =

>>
>> Cheers,
>> Matt
>>
>>> ---
>>>    tools/testing/selftests/kselftest/runner.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testin=
g/selftests/kselftest/runner.sh
>>> index 84de7bc74f2c..0d7a89901ef7 100644
>>> --- a/tools/testing/selftests/kselftest/runner.sh
>>> +++ b/tools/testing/selftests/kselftest/runner.sh
>>> @@ -90,7 +90,7 @@ run_one()
>>>    run_many()
>>>    {
>>>    	echo "TAP version 13"
>>> -	DIR=3D$(basename "$PWD")
>>> +	DIR=3D"${PWD#${BASE_DIR}/}"
>>>    	test_num=3D0
>>>    	total=3D$(echo "$@" | wc -w)
>>>    	echo "1..$total"
>>> -- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3241759639719151708==--
