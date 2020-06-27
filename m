Content-Type: multipart/mixed; boundary="===============8453291863777233309=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "net: mptcp: improve fallback to TCP"
Date: Sat, 27 Jun 2020 09:50:48 +0200
Message-ID: <cd2d13dd-bce6-02df-6cc8-8e80605888b3@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2006260916580.66996@redsall-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4840

--===============8453291863777233309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 26/06/2020 18:17, Mat Martineau wrote:
> =

> On Fri, 26 Jun 2020, Paolo Abeni wrote:
> =

>> This fixes blocking accept() never waking-up.
>>
>> When blocking, mptcp_stream_accept() calls into:
>> ssock->ops->acceptk -> ssock->sk->sk_prot->accept ->
>> inet_csk_accept() -> inet_csk_wait_for_connect(),
>>
>> which in turns waits on ssock->sk->sk_wq, while
>> all signaling how happens on sock->sk->sk_wq.
>>
>> Since we ssock->sk->sk_wq is never used otherwise,
>> just copy sock->sk->sk_wq into it at first subflow
>> creatin time.
> =

> This fixes the problem for me - thanks Paolo!

Thank you for the patch and the review!

- 9d9ba398bf90: "squashed" in "net: mptcp: improve fallback to TCP"
- e3f1af462a5e: conflict in =

t/mptcp-create-first-subflow-at-msk-creation-time
- 0367023402da..e1929209d8a3: result

Tests are still OK (except the issue with Packetdrill)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8453291863777233309==--
