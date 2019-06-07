Content-Type: multipart/mixed; boundary="===============3724632917921933902=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 5/7] mptcp: parsing DSS option should use own
 flags field.
Date: Fri, 07 Jun 2019 13:23:35 +0200
Message-ID: <0913f773-a4cb-e088-f17a-53222a15b6cc@tessares.net>
In-Reply-To: 20190606003632.2863-6-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1311

--===============3724632917921933902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/06/2019 02:36, Peter Krystad wrote:
> It is possible that both MP_CAPABLE and DSS options are
> received in the same header, so they cannot share fields.
> =

> squashto: Implement MPTCP reveive path.

Thank you for the patch and the review!

- c30fe64dafe0: "squash" in "mptcp: Implement MPTCP reveive path"
- signed-off was already there
- no conflict
- 612e3f6c26e6..666387ce8fc1: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3724632917921933902==--
