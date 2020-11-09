Content-Type: multipart/mixed; boundary="===============5687829144345423355=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net 0/2] fix static checker warnings in
Date: Mon, 09 Nov 2020 21:59:20 +0800
Message-ID: <cover.1604930005.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6597

--===============5687829144345423355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset fixed static checker warnings in mptcp_pm_add_timer and
mptcp_pm_alloc_anno_list.

Geliang Tang (2):
  mptcp: fix static checker warnings in mptcp_pm_add_timer
  mptcp: cleanup for mptcp_pm_alloc_anno_list

 net/mptcp/pm_netlink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- =

2.26.2

--===============5687829144345423355==--
