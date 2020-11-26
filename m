Content-Type: multipart/mixed; boundary="===============6320360853711444265=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix NULL ptr dereference on bad MPJ
Date: Thu, 26 Nov 2020 12:27:05 +0100
Message-ID: <1d5adbd3-e05b-2afb-7691-87f97275ffd4@tessares.net>
In-Reply-To: 7245da72fb7b1936b2c872c8a8c465012763ed17.1606385694.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6948

--===============6320360853711444265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/11/2020 11:15, Paolo Abeni wrote:
> If an msk listener receives an MPJ carrying an invalid token, it
> will zero the request socket msk entry. That should later
> cause fallback and subflow reset - as per RFC - at
> subflow_syn_recv_sock() time due to failing hmac validation.
> =

> Since commit 4cf8b7e48a09 ("subflow: introduce and use
> mptcp_can_accept_new_subflow()"), we unconditionally dereference
> - in mptcp_can_accept_new_subflow - the subflow request msk
> before performing hmac validation. In the above scenario we
> hit a NULL ptr dereference.
> =

> Address the issue doing the hmac validation earlier.

Thanks for the fix!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Just added in our tree:
- 8e76b1043ebe: mptcp: fix NULL ptr dereference on bad MPJ
- Results: a7a4732c5cdb..aad014029dd8

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6320360853711444265==--
