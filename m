Content-Type: multipart/mixed; boundary="===============2783214249539816021=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next] mptcp: use the variable sk
 instead of open-coding
Date: Wed, 25 Nov 2020 12:34:42 +0100
Message-ID: <21a33479-97ef-59ec-2248-2e8f72ca4ccb@tessares.net>
In-Reply-To: 324b7fd5919dc934355ce13da4c71dc26e0aba8a.1606102511.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6928

--===============2783214249539816021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 23/11/2020 04:37, Geliang Tang wrote:
> Since the local variable sk has been defined, use it instead of
> open-coding.

Thank you for the cleanup!
Just added at the end of the tree.

- 2d7ef2938b20: mptcp: use the variable sk instead of open-coding
- Results: 5e15564c598e..e91e7cc78e40

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2783214249539816021==--
