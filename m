Content-Type: multipart/mixed; boundary="===============6295401212610487333=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Thu, 12 Dec 2019 16:27:52 +0100
Message-ID: <c4142b7ad1ca1e383217a58841a27e9eb6c36236.camel@redhat.com>
In-Reply-To: afc3068e9c228b78ab384be40da1152ba5bfc6a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2886

--===============6295401212610487333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 20:00 +0100, Paolo Abeni wrote:
> On Wed, 2019-12-11 at 17:32 +0100, Paolo Abeni wrote:
> > On Tue, 2019-12-10 at 22:27 +0100, Matthieu Baerts wrote:
> > > =

> This one had a couple of gross mistake, just cooked a less bugged
> version. The new tree is here:
> =

> https://github.com/pabeni/mptcp/commits/fwestpha-mptcp_export_rebase_19_f=
allback_cleanup_3
> =

> The only updated patch is the last one:

FYI, Paolo did a newer version at

https://github.com/pabeni/mptcp/commits/fwestpha-mptcp_export_rebase_19_fal=
lback_cleanup_4

that has squashed the fixes. Over that tree, I fixed most of checkpatch iss=
ues
on the first 26 patches (up to kselftests), rebuilt, retested and pushed at

https://github.com/dcaratti/mptcp/tree/fwestpha-mptcp_export_rebase_19_fall=
back_cleanup_5

Please find below the list of patches where the code actually changed:

0003-tcp-Define-IPPROTO_MPTCP.patch  =

0013-mptcp-Handle-MPTCP-TCP-options.patch
0017-mptcp-Add-key-generation-and-token-tree.patch
0020-mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packe.patch
0021-mptcp-Implement-MPTCP-receive-path.patch
0022-mptcp-add-subflow-write-space-signalling-and-mptcp_p.patch
0023-mptcp-recvmsg-can-drain-data-from-multiple-subflows.patch
0026-mptcp-add-basic-kselftest-for-mptcp.patch
0027-mptcp-move-from-sha1-v0-to-sha256-v1.patch
0028-mptcp-parse-and-emit-MP_CAPABLE-option-according-to-.patch
0031-mptcp-Add-ADD_ADDR-handling.patch

-- =

davide



--===============6295401212610487333==--
