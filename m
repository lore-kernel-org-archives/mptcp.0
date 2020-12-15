Content-Type: multipart/mixed; boundary="===============1339667040164393976=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: properly annotate nested lock
Date: Tue, 15 Dec 2020 12:44:54 +0100
Message-ID: <ffdb98bb-7d11-5135-4f18-63b15f491279@tessares.net>
In-Reply-To: 50af234d94b3b4cd596782e094222837702b7641.1607965491.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7174

--===============1339667040164393976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 14/12/2020 18:49, Paolo Abeni wrote:
> MPTCP closes the subflows while holding the msk-level lock.
> While acquiring the subflow socket lock we need to use the
> correct nested annotation, or we can hit a lockdep splat
> at runtime.
> =

> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for this fix! Now in our tree!

- 87e250484c27: mptcp: properly annotate nested lock
- Results: d73b2c933a85..e1e3f281c849

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1339667040164393976==--
