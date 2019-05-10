Content-Type: multipart/mixed; boundary="===============3997905065463044655=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Check for filled TCP option space before SACK
Date: Fri, 10 May 2019 16:59:58 -0700
Message-ID: <alpine.OSX.2.21.1905101643530.59728@julieann-mobl1.amr.corp.intel.com>
In-Reply-To: 3fda5a02-3ea9-688e-ac33-1b7b12309889@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1146

--===============3997905065463044655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 10 May 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you for the patch!
>
> On 09/05/2019 19:06, Mat Martineau wrote:
>> The SACK code would potentially add four bytes to the expected
>> TCP option size even if all option space was already used.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/ipv4/tcp_output.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 12c9e8ebc86d..1cd915890ce5 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -814,6 +814,9 @@ static unsigned int tcp_established_options(struct s=
ock *sk, struct sk_buff *skb
>>  		}
>>  	}
>>
>> +	if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_OPTION_SPACE)
>> +		return size;
>> +
>
> Should we not add this check in the "if" block here below...
>
>>  	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>>  	if (unlikely(eff_sacks)) {
>>  		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
>
> ... to use this "remaining" variable only if we want to add SACKS:
>
>    if (TCPOLEN_SACK_BASE_ALIGNED >=3D remaining)
>        return size;

Florian had suggested the above location (#2 in =

https://lists.01.org/pipermail/mptcp/2019-April/001097.html). Seemed like =

adding the check there made sense because there's no need to calculate =

eff_sacks if there's no option space.

>
>
> Do you want me to squash this fix in Peter's commit (mptcp: Handle
> MP_CAPABLE options for outgoing connections) or to add it as a new
> commit just after Peter's one? (It's only to ease the "rebasing" task
> later by helping doing a maximum now as long as I can help :) )

I'd prefer to add commits to the end so it's easier for everyone to see =

what's changing over time.

--
Mat Martineau
Intel

--===============3997905065463044655==--
