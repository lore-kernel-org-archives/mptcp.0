Content-Type: multipart/mixed; boundary="===============0393193148507904958=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] Squash-to: "mptcp: Implement MPTCP receive
 path"
Date: Wed, 18 Dec 2019 16:32:11 +0100
Message-ID: <6b16645aa5c2ab2063a64c9b287d41ffdf257e64.camel@redhat.com>
In-Reply-To: ae0ce521-b657-741b-a106-87a3c3fa3639@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3140

--===============0393193148507904958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 16:22 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 18/12/2019 13:33, Paolo Abeni wrote:
> > drop C++ style comment, we have explicit checks in place
> > for supported flags
> =

> Thank you for these two patches!
> =

> It looks good to me, good catch! Please check the conflict resolution =

> and result to make sure I did this correctly.
> =

> - 1c8b2fdb49ea: "squashed" patch 1/2 in "mptcp: Add MPTCP socket stubs"
> - 490e2f994f44: "squashed" patch 2/2 in "mptcp: Implement MPTCP receive =

> path"
> - b48b06bb1b2b: conflict in =

> t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
> - ba600451fc45..27be141bb6d9: result

LGTM!

Thanks,

Paolo

--===============0393193148507904958==--
