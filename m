Content-Type: multipart/mixed; boundary="===============1811761148019148831=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/12] pm netlink: followup and fixes
Date: Thu, 12 Mar 2020 10:34:59 +0100
Message-ID: <5a898d2f3185cd57b3b7700abc8c580308e0e89b.camel@redhat.com>
In-Reply-To: 60fd12e6-fdf3-f370-d0cc-c113be5b9cf4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3932

--===============1811761148019148831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-11 at 20:59 +0100, Matthieu Baerts wrote:
> *Paolo* : there is one comment for you below:
> =

> =

> - the first patch has been applied as a new topic (exported commit) at =

> the beginning of the series. =E2=86=92 t/mptcp-rename-fourth-ack-field
> - 5a5f6637f84f: conflict in =

> t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
> - b5b033c18651..a6e8ad2a3769: result
> =

> - 1e9a3e8639eb: "squashed" patch 2/12 in "mptcp: Add path manager =

> interface" (not on top of "mptcp: Add ADD_ADDR handling")
> - 02ebff8a2889: conflict in =

> t/mptcp-Implement-path-manager-interface-commands
> - a6e8ad2a3769..b9678d1875a3: result
> =

> - 0e515e7616d3: "squashed" patch 3/12 in "mptcp: Add handling of =

> incoming MP_JOIN requests"
> =E2=86=92 *Paolo*: I removed the new comment "passive connection, attach =
to msk =

> socket" as you did in your branch. Was it OK?

Yep, look good to me!

I'll have a better look at the code while working at more follow-up
patches to fix sporadic self-tests failures.

Thank you for your great work!

Paolo


--===============1811761148019148831==--
