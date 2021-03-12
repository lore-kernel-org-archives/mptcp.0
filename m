Content-Type: multipart/mixed; boundary="===============1114008127285912085=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 15:11:33 +0100
Message-ID: <e37660e0-9ec9-a60f-85bb-d8e7b783007e@tessares.net>
In-Reply-To: CA+WQbwuBi+fUvbFPo-QxVrxAzY64QWpMxiWCKZak8=8Cvfk+8g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8116

--===============1114008127285912085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thank you for the quick review!

On 12/03/2021 15:06, Geliang Tang wrote:
> Hi Matt,
> =

> Thanks for this fix.
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> Avoid calling pm_nl_ctl with id > 255.
>>
>> Without this patch, we can see this when running the selftests:
>>
>>    selftests: net/mptcp: pm_netlink.sh
>>    (...)
>>    above hard addr limit                              [ OK ]
>>    ./pm_nl_ctl add|get|set|del|flush|dump|accept
>>     add [flags signal|subflow|backup] [id <nr>] [dev <name>] <ip>
>>    del <id>
>>     get <id>
>>     set <ip> [flags backup|nobackup]
>>     flush
>>     dump
>>    limits [<rcv addr max> <subflow max>]
>>
>>    id limit                                           [ OK ]
>>    (...)
>>
>> That's because we were calling:
>>
>>    $ pm_nl_ctl del 256
>>
>> In the code, the parsed ID is written in a u_int8_t. Then the value
>> "256" is stored as "0" which is now a special case and requires an IP.
>>
>> We could modify pm_nl_ctl but stop if the ID is negative or higher than
>> 255 but not sure we need this for a tool only used in selftests.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "selftests: mptcp: add addr argument for del_addr"
> =

> I think this patch should be a single standalone patch, not a squash-to
> one.

If I do the modification you propose, should I not keep this as a =

squash-to patch?

>>
>>   tools/testing/selftests/net/mptcp/pm_netlink.sh | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/tes=
ting/selftests/net/mptcp/pm_netlink.sh
>> index a617e293734c..365ba4611ae7 100755
>> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
>> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
>> @@ -100,9 +100,10 @@ done
>>   check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1=
.9" "hard addr limit"
>>   check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limi=
t"
>>
>> -for i in `seq 9 256`; do
> =

> Could we just simply change this '256' to '255', with no other changes?
> Like this:
> =

>      -for i in `seq 9 256`; do
>      +for i in `seq 9 255`; do

Indeed, I should have stopped there.
I noticed that we were not deleting the last ID (256+1) but we don't =

really care and that's not important.

I will go back to my previous version and only change the last ID.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1114008127285912085==--
