Content-Type: multipart/mixed; boundary="===============1327726324164513631=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Thu, 26 Sep 2019 17:05:19 +0200
Message-ID: <20190926150519.GA9938@breakpoint.cc>
In-Reply-To: 98dbc8863e23c4662815d9df5f8f5d7c8d2d4405.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1934

--===============1327726324164513631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> We (well, mainly poor Florian) are working to a rebase. Main reason for
> rebase is that the squashing proved to be quite complex. Likely a pull
> request could be shared very soon, but any export branch change from
> now one will likely be omitted.

Paolo placed current iteration here:

https://github.com/pabeni/mptcp/commits/export_squash_09_more_nit

Following patches were folded (some were split and merged in
several other patches).

Florian:
mptcp: add and use mptcp_subflow_hold
mptcp: selftests: switch to netns+veth based tests
mptcp: accept: don't leak mptcp socket structure
mptcp: switch sublist to mptcp socket lock protection
mptcp: token: add mptcp prefixes to functions

Mat:
mptcp: selftests: Add capture option

Peter:
tcp: Make connection_list a real list of subflows

This results in 40 patches. The series is bisectable.

There are a few more candidates, e.g.
  mptcp: harmonize locking on all socket operations

from Paolo.

But I figured it would make sense to share this now and discuss
how to proceed from here first.

--===============1327726324164513631==--
