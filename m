Content-Type: multipart/mixed; boundary="===============6562019806292333207=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] mptcp: disable mptcp when md5sig is set on socket
Date: Mon, 11 Nov 2019 17:53:49 +0100
Message-ID: <cover.1573488686.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2466

--===============6562019806292333207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per last public mtg discussion, md5sig will cause TCP option space
exaustion. Without md5sig we can't exhaust the TCP option space.

This series explcitly disable MPTCP when md5sig is set, and cleanup
later option len checks with the assumption that TCP option space exhaustion
is not expected - add a single WARN_ON() for that.

Paolo Abeni (1):
  mptcp: move mp_capable initialization at subflow_init_req() start
  mptcp: disable on req sk if MD5SIG is enabled
  mptcp: warn once if exceeding tcp opt space for dss/mp_capable
  mptcp: remove unneeded check in mptcp_established_options_mp()

 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- =

2.21.0

--===============6562019806292333207==--
