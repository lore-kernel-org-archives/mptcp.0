Content-Type: multipart/mixed; boundary="===============8999584605995720998=="
MIME-Version: 1.0
From: Bo YU <tsu.yubo at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH V2 -next] mptcp/pm_netlink.c : add check for
 nla_put_in/6_addr
Date: Wed, 22 Apr 2020 22:56:21 +0800
Message-ID: <20200422145618.b5qshinlmi26i6ko@host>
In-Reply-To: f82e4d00d4d4680994f0885c55831b2e9a2299c1.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4227

--===============8999584605995720998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 12:12:27PM +0200, Paolo Abeni wrote:
>On Wed, 2020-04-22 at 09:34 +0800, Bo YU wrote:
>> Normal there should be checked for nla_put_in6_addr like other
>> usage in net.
>>
>> Detected by CoverityScan, CID# 1461639
>>
>> Fixes: 01cacb00b35c("mptcp: add netlink-based PM")
>> Signed-off-by: Bo YU <tsu.yubo(a)gmail.com>
>> ---
>> V2: Add check for nla_put_in_addr suggested by Paolo Abeni
>
>Thank you for addressing my feedback!
>
>> ---
>>  net/mptcp/pm_netlink.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 86d61ab34c7c..0a39f0ebad76 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -599,12 +599,15 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
>>  	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
>>  		goto nla_put_failure;
>>
>> -	if (addr->family =3D=3D AF_INET)
>> +	if (addr->family =3D=3D AF_INET &&
>>  		nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
>> -				addr->addr.s_addr);
>> +				addr->addr.s_addr))
>> +		goto nla_put_failure;
>> +
>
>I'm very sorry about the nit-picking, but the above is now a single
>statement, and indentation should be adjusted accordingly:
>'nla_put_in_addr()' should be aligned with 'addr->family'.
Ok, but i just want to make clear for that, do you mean:


	if (addr->family =3D=3D AF_INET && nla_put_in_addr(skb,
			MPTCP_PM_ADDR_ATTR_ADDR4, addr->addr.s_addr))

In fact, i was upset by checkpatch about over 80 chars warning.
This is my originally version patch to fix it :(. If i was wrong
to understand your means, please  correct me. Thank you.

>
>The same applies to the chunk below.
>
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -	else if (addr->family =3D=3D AF_INET6)
>> -		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6);
>> +	else if (addr->family =3D=3D AF_INET6 &&
>> +		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6))
>> +		goto nla_put_failure;
>>  #endif
>>  	nla_nest_end(skb, attr);
>>  	return 0;
>
>Otherwise LGTM, thanks!
>
>Paolo
>
--===============8999584605995720998==--
