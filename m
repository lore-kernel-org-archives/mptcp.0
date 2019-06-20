Content-Type: multipart/mixed; boundary="===============5531713467221275315=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 1/2] net: mptcp: randomness improvements for
 crypto.c
Date: Thu, 20 Jun 2019 09:45:16 -0700
Message-ID: <alpine.OSX.2.21.1906200858270.44348@kdmease-mobl.amr.corp.intel.com>
In-Reply-To: 20190615090709.wy5545fcybav4cav@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1433

--===============5531713467221275315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sat, 15 Jun 2019, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>> -	return hsiphash(&combined, offsetofend(typeof(combined), dport),
>>> -			&crypto_nonce_secret);
>>> +			    tcp_cookie_time(), &crypto_key_secret);
>>
>> tcp_cookie_time() adds a dependency on CONFIG_SYN_COOKIES. It also looks
>> like tcp_cookie_time() only increments once per second, so the uniquenes=
s of
>> the key (within a 1-second interval) becomes totally dependent on the
>> uniqueness of the 4-tuple. I think a different seed source is needed that
>> won't repeat so predictably.
>
> Thats a good point, this means we will also need to include
> net_hash_mix() into the input so we won't create same keys for identical
> tuples in different network namespaces.
>
> But, I wonder, if the key doesn't need to be recomputeable at all, then
> this is just a random value to send, so two alternatives might be:
>
> 1. just use get_random_bytes
> 2. use prandom_u32() as additional input key instead of increment++.

We talked about this in the meeting today. Right now there's no =

recomputing of the key, so a random key would be simplest. I'm not sure if =

that's more expensive to compute, but we are not locking ourselves in to =

anything with our key generation choice now.

--
Mat Martineau
Intel

--===============5531713467221275315==--
