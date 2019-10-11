Content-Type: multipart/mixed; boundary="===============2031532014760058382=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] add Co-developed-by tag
Date: Fri, 11 Oct 2019 17:46:29 +0200
Message-ID: <f2eae9f6-762a-303a-901b-2df193473b18@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2097

--===============2031532014760058382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As requested by our new layer Paolo (OK, now it is your turn to be =

authorized to hate me!), I just added Co-developed-by tags using a =

script [1]. Here is an example of the modification that has been applied =

for "mptcp: add basic kselftest for mptcp":


   From Matthieu Baerts: Add sysctl test
   From Paolo Abeni: Use tc/ethtool to test more skb handling code paths

  -Signed-off-by: Florian Westphal <fw(a)strlen.de>
  +Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
   Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
  +Co-developed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
   Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
  +Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
   Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
  +Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
   Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
  +Signed-off-by: Florian Westphal <fw(a)strlen.de>

I hope I correctly understood the doc[2]. Here are the modifications I did:


- bd7e711d2a32: added Co-developed-by in t/mptcp-Add-MPTCP-to-skb-extensions
- 4af61fb78bb5: added Co-developed-by in =

t/tcp-Export-TCP-functions-and-ops-struct
- 1585f0f743cc: added Co-developed-by in t/tcp-clean-ext-on-tx-recycle
- cc24553aa9c8: added Co-developed-by in t/mptcp-Add-MPTCP-socket-stubs
- b40d1790eef7: added Co-developed-by in t/mptcp-Handle-MPTCP-TCP-options
- f96e8008e96c: added Co-developed-by in =

t/mptcp-Associate-MPTCP-context-with-TCP-socket
- 23ddd0d11365: added Co-developed-by in =

t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- 862a3b653fbe: added Co-developed-by in =

t/mptcp-Add-key-generation-and-token-tree
- bda17a63d162: added Co-developed-by in =

t/mptcp-Add-setsockopt-getsockopt-socket-operations
- 2e8e4c744388: added Co-developed-by in =

t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets
- 0c71387abf95: added Co-developed-by in =

t/mptcp-Implement-MPTCP-receive-path
- 6e6feed018bf: added Co-developed-by in t/mptcp-Add-path-manager-interface
- f6937fc624d7: added Co-developed-by in =

t/mptcp-harmonize-locking-on-all-socket-operations
- 26dbeddb01c4: added Co-developed-by in =

t/mptcp-add-basic-kselftest-for-mptcp
- ff04a4e0c349: added Co-developed-by in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 6f36e3956483: added Co-developed-by in =

t/mptcp-Implement-path-manager-interface-commands
- 0e9ca364b916: added Co-developed-by in =

t/mptcp-allow-dumping-subflow-context-to-userspace


Next time we have signed-off to add, Co-developed-by will be added =

automatically as well.

Cheers,
Matt

[1] =

https://github.com/multipath-tcp/mptcp_net-next/blob/scripts/utils/add_co_d=
ev.py
[2] =

https://elixir.bootlin.com/linux/v5.4-rc2/source/Documentation/process/subm=
itting-patches.rst#L548
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2031532014760058382==--
