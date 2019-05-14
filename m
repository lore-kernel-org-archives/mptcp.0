Content-Type: multipart/mixed; boundary="===============1021657560534480998=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: refactor shutdown/close and conn_list
 handling
Date: Tue, 14 May 2019 18:10:11 +0200
Message-ID: <379e9ea7-afa9-3b52-187b-8f8f02d74814@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905101735420.59728@julieann-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1167

--===============1021657560534480998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/05/2019 02:38, Mat Martineau wrote:
> =

> On Fri, 10 May 2019, Paolo Abeni wrote:
> =

>> This change the conn_list to a plain list and use the mptcp socket
>> lock to mutually exclude shutdown and close execution.
>>
>> Since mptcp_close() is the only code path that removes entries from
>> conn_list, we can safely traverse the list while interrupting the
>> he RCU critical section.
>>
>> This solves the scheduling while atomic splat on shutdown, but still
>> retain the RCU sync on close.
> =

> Looks good to me.
> =

> =

> Mat
> =

> =

>>
>> v1 -> v2:
>> - use the mptcp socket lock in shutdown and close
>>
>> Fixes: ed375420f78d ("mptcp: Make connection_list a real list of
>> subflows")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> Notes:
>> - this can be squashed into the fixes commit

Just squashed as requested:
- Squash: b43d52fa72f672b26a53bded8e5b3caca7a18e0e
- The sign-off and modification of the commit message:
2c7a14b986f1e1671c2496365dbf6a4ddfc38597

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1021657560534480998==--
