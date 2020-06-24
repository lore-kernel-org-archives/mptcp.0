Content-Type: multipart/mixed; boundary="===============7204428289651884610=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: __mptcp_tcp_fallback() returns a struct
 sock
Date: Wed, 24 Jun 2020 18:38:01 +0200
Message-ID: <e6c94c03-77f4-36bf-1dfe-f2161a5c473e@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2006230937390.17634@jtang15-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4785

--===============7204428289651884610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 23/06/2020 18:38, Mat Martineau wrote:
> =

> On Tue, 23 Jun 2020, Paolo Abeni wrote:
> =

>> Currently __mptcp_tcp_fallback() always return NULL
>> on incoming connections, because MPTCP does not create
>> the additional socket for the first subflow.
>> Since the previous commit no __mptcp_tcp_fallback()
>> caller needs a struct socket, so let __mptcp_tcp_fallback()
>> return the first subflow sock and cope correctly even with
>> incoming connections.
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> v2 -> v2:
>> - update commit message
> =

> Thanks Paolo, this looks good for merging.

Thank you for the patch and the review!

I just added this patch after "mptcp: create first subflow at msk =

creation time"

- ec82c0444348: mptcp: __mptcp_tcp_fallback() returns a struct sock

Tests and export are in progress.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7204428289651884610==--
