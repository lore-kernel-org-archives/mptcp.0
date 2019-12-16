Content-Type: multipart/mixed; boundary="===============6999798539391648526=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Mon, 16 Dec 2019 19:32:16 +0100
Message-ID: <827d739f-ec0d-9bab-eb16-a79c907799d8@tessares.net>
In-Reply-To: 23d83c427a276680e731ec50541e7599ecc80b9a.1576518799.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3088

--===============6999798539391648526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 18:55, Paolo Abeni wrote:
> Clean subflow->conn, under the ssk socket lock, and make
> __mptcp_tcp_fallback() less unreadable.
> =

> v1 -> v2:
>   - fix more typos (Matt)

Thank you for this v2!

- f8725729308f: "squashed" in "mptcp: cope with later TCP fallback"
- e999bb17232e..20ba1573a74f: result

Tests + export is in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6999798539391648526==--
