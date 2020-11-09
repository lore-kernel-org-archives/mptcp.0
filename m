Content-Type: multipart/mixed; boundary="===============8211388820203042656=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: provide rmem[0] limit
Date: Mon, 09 Nov 2020 18:20:50 +0100
Message-ID: <d49c966b-e2fe-e0c9-49ea-a7a2475f45cf@tessares.net>
In-Reply-To: 37af798bd46f402fb7c79f57ebbdd00614f5d7fa.1604861097.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6609

--===============8211388820203042656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 08/11/2020 19:49, Paolo Abeni wrote:
> The mptcp proto struct currently does not provide the
> required limit for forward memory scheduling. Under
> pressure sk_rmem_schedule() will unconditionally try
> to use such field and will oops.
> =

> Address the issue inheriting the tcp limit, as we already
> do for the wmem one.
> =

> Fixes: ("mptcp: add missing memory scheduling in the rx path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Good catch, thank you for this patch!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8211388820203042656==--
