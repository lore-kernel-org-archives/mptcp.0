Content-Type: multipart/mixed; boundary="===============3565511244807044429=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] options: copy entire extension area to
 option struct
Date: Sat, 05 Oct 2019 11:18:24 +0200
Message-ID: <cee34224-bf7b-fd4e-e030-b97603d0c1be@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910041545330.58686@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2024

--===============3565511244807044429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 05/10/2019 00:46, Mat Martineau wrote:
> =

> On Fri, 4 Oct 2019, Florian Westphal wrote:
> =

>> No reason to copy each member individually, just copy everything.
>> This means we will also copy ext->data_fin which was not done before.
> =

> Looks good to me. I think the missing data_fin copy was a bug.

Thank you for the patch -- good catch -- and the review!

- e00602aa68b2: "squashed" in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
- already has signed-off
- 2f9e62154e58..94fbc140ae04: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3565511244807044429==--
