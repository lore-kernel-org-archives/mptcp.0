Content-Type: multipart/mixed; boundary="===============2958630319222163243=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: fix length of ADD_ADDR with port
 suboption
Date: Mon, 08 Mar 2021 11:49:22 +0100
Message-ID: <614f4ddb-fdc5-1cd7-b651-570cdcbd72e6@tessares.net>
In-Reply-To: dfea8e080c5e8bbcbeefa64a4b8d7ff2becea639.1614874814.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8072

--===============2958630319222163243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Geliang, Mat,

On 04/03/2021 17:23, Davide Caratti wrote:
> in current Linux, MPTCP peers advertising endpoints with port numbers use
> a sub-option length that wrongly accounts for the trailing TCP NOP. Also,
> receivers will only process incoming ADD_ADDR with port having such wrong
> sub-option length. Fix this, making ADD_ADDR compliant to RFC8684 =C2=A73=
.4.1.
> =

> this can be verified running tcpdump on the kselftests artifacts:

Thank you for the patch, review and testing!

Sorry for the delay to apply it, I was doing other modifications in the =

tree to ease CI scripts and because I got a conflict with the export =

branch, I didn't apply it before :)

- 268780afbf25: mptcp: fix length of ADD_ADDR with port sub-option
- d16c1995a017: conflict in t/mptcp-add-rm_list-in-mptcp_out_options
- Results: b6772f0348c6..ec0b131d1b83

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2958630319222163243==--
