Content-Type: multipart/mixed; boundary="===============3352255723560668528=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: push pending frames when
 subflow has free space
Date: Thu, 10 Dec 2020 10:54:08 +0100
Message-ID: <02d41e39-01ad-820a-408b-790c90610432@tessares.net>
In-Reply-To: 41eec9f439fdbe2ae5549f6222af4b24f58c0af5.1607535998.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7123

--===============3352255723560668528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 09/12/2020 18:46, Paolo Abeni wrote:
> When multiple subflows are active, we can receive a
> window update on subflow with no write space available.
> MPTCP will try to push frames on such subflow and will
> fail. Pending frames will be pushed only after receiving
> a window update on a subflow with some wspace available.
> =

> Overall the above could lead to suboptimal aggregate
> bandwidth usage.
> =

> Instead, we should try to push pending frames as soon as
> the subflow reaches both conditions mentioned above.
> =

> We can finally enable self-tests with asymmetric links,
> as the above makes them finally pass.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch and the review!
Just applied in our tree:

- bbaa11040198: mptcp: push pending frames when subflow has free space
- Results: 3f7872297b23..ffc63be6523f

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3352255723560668528==--
