Content-Type: multipart/mixed; boundary="===============6255685659546281845=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: add
 IPv4-mapped IPv6 testcases
Date: Mon, 21 Dec 2020 12:49:15 +0100
Message-ID: <f0a0f5c3-c047-44f0-c4bf-3612a31b5515@tessares.net>
In-Reply-To: CA+WQbws31bk_d2JzL8-zGH+pZ5baYctfQKKvyy=SYev49TT3QQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7233

--===============6255685659546281845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 21/12/2020 11:16, Geliang Tang wrote:
> Hi Matt,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> From: Geliang Tang <geliangtang(a)gmail.com>
>>
>> Here, we make sure we support IPv4-mapped in IPv6 addresses in different
>> contexts:

(...)

>> +# no subflow IPv6 to v4 address
>> +reset
>> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
>> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
>> +ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
> =

> dead:beef:2::10.0.3.2 is a invalid address, should we use dead:beef:3::2 =
here?

I used "dead:beef:2::10.0.3.2" on purpose just to have a valid and =

usable IPv4 address at the end of the v6 one. If we try to use the IPv4 =

address at the end of this v6 one, we will send the SYN+MPJ to the =

correct host (no routing issue). With the previous version of this =

patchset (v3), this was creating a subflow with 10.0.3.2!

I should certainly add a new comment here.
Maybe you would prefer an additional test with "dead:beef:3::2" as well?

>> +run_tests $ns1 $ns2 "10.0.1.1"
> =

> We can drop the quotation marks here, only the IPv4-mapped address need
> the quotation marks.

Yes, I usually add quotes in Bash for each string but I see we didn't do =

that for the other tests, I will remove that!

> And add "0 0 0 slow" behind it, since the test need to slow down when use
> the IPv6 address.

Do I need to do that here as well even if we don't create v6 subflows?

>> +chk_join_nr "no JOIN with different families v4-v6" 0 0 0
> =

> This string is too long, it break the alignment of the output. Can we use
> "diff" here instead of "different"?

Good point, I didn't check that! I will short "different", good idea!

>> +
>> +# no subflow IPv4 to v6 address
>> +reset
>> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
>> +ip netns exec $ns2 ./pm_nl_ctl limits 0 1
>> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
>> +run_tests $ns1 $ns2 dead:beef:1::1
> =

> Add "0 0 0 slow" here.

Same here, is it needed if we don't create any IPv6 subflow?

>> +chk_join_nr "no JOIN with different families v6-v4" 0 0 0
> =

> This string is too long too.

Will do in v5!

Thanks for the review!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6255685659546281845==--
