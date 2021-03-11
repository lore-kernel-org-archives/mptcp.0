Content-Type: multipart/mixed; boundary="===============4855777258387260769=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "mptcp: only admit explicitly
 supported sockopt"
Date: Thu, 11 Mar 2021 11:11:27 +0100
Message-ID: <20210311101127.1774603-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8097

--===============4855777258387260769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SO_SNDTIMEO_{OLD,NEW} were missing in the list. They are considered as
"quite common but need a better implementation".

Indeed, as mentioned by Paolo: these settings are applied only to the
first subflow, while mptcp_recvmsg()/mptcp_sendmsg() will look for the
timeout value in the msk socket.

At least with these patches, we can have MPTCP BPF selftest passing:

  ./test_progs -n 66

Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: only admit explicitly supported sockopt"

 net/mptcp/sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3eda9127debb..fb98fab252df 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -110,6 +110,8 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 		case SO_RCVLOWAT:
 		case SO_RCVTIMEO_OLD:
 		case SO_RCVTIMEO_NEW:
+		case SO_SNDTIMEO_OLD:
+		case SO_SNDTIMEO_NEW:
 		case SO_MARK:
 		case SO_INCOMING_CPU:
 		case SO_BINDTOIFINDEX:
-- =

2.30.1

--===============4855777258387260769==--
