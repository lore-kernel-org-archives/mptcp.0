Content-Type: multipart/mixed; boundary="===============1896204437712862685=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] kbuild is working again, found a failure
Date: Fri, 12 Mar 2021 11:19:17 -0800
Message-ID: <885b44af-ca88-bea8-c824-f5cc8a89e2d@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8127

--===============1896204437712862685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

Thanks Matthieu for adding the "static_call: Fix the module key fixup" =

commit to the mptcp_net-next repository, the kbuild tests are now running =

again.

There was a failure in mptcp_join.sh:

user  :notice: [  380.427338] # 24 remove invalid addresses             syn=
[ ok ] - synack[ ok ] - ack[ ok ]
user  :notice: [  380.456500] #                                         add=
[ ok ] - echo  [ ok ]
user  :notice: [  380.472445] #                                         rm =
[fail] got 2 RM_ADDR[s] expected 3
user  :notice: [  380.488441] #  - sf    [ ok ]
user  :notice: [  380.493351] # Server ns stats
user  :notice: [  380.499668] # MPTcpExtMPCapableSYNRX          1          =
        0.0
user  :notice: [  380.508705] # MPTcpExtMPCapableACKRX          1          =
        0.0
user  :notice: [  380.518042] # MPTcpExtMPJoinSynRx             1          =
        0.0
user  :notice: [  380.527101] # MPTcpExtMPJoinAckRx             1          =
        0.0
user  :notice: [  380.536145] # MPTcpExtEchoAdd                 3          =
        0.0
user  :notice: [  380.545105] # MPTcpExtRmSubflow               1          =
        0.0
user  :notice: [  380.553759] # Client ns stats
user  :notice: [  380.559474] # MPTcpExtMPCapableSYNTX          1          =
        0.0
user  :notice: [  380.568482] # MPTcpExtMPCapableSYNACKRX       1          =
        0.0
user  :notice: [  380.577496] # MPTcpExtMPJoinSynAckRx          1          =
        0.0
user  :notice: [  380.586552] # MPTcpExtAddAddr                 3          =
        0.0
user  :notice: [  380.595546] # MPTcpExtRmAddr                  2          =
        0.0

--
Mat Martineau
Intel
--===============1896204437712862685==--
