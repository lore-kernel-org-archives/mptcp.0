Content-Type: multipart/mixed; boundary="===============0116429450024558319=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Fri, 23 Oct 2020 18:03:52 +0200
Message-ID: <697d818f-1457-6d9b-49e3-647c65fd3b22@tessares.net>
In-Reply-To: a54e1b917f151b550951a0bad0b69a4924885ce1.1603211002.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6420

--===============0116429450024558319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 20/10/2020 18:25, Paolo Abeni wrote:
> we must release the ssk socket only after orphaning it,
> or we may hit UaF in the receive path.
> =

> Beyond the error critical code path reported by syzkaller,
> there is also the scenario of a subflow closed by the PM.

Thank you for this patch and the review!

- 51c3efe449ec: "squashed" in "mptcp: refactor shutdown and close"
- Results: da50c705808b..62d3c2d391fa

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0116429450024558319==--
