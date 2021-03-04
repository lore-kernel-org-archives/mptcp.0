Content-Type: multipart/mixed; boundary="===============0684315294323493804=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/6] mptcp: avoid passing rm_list as
 a struct
Date: Thu, 04 Mar 2021 14:42:42 +0800
Message-ID: <20210304064248.9636-1-geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8009

--===============0684315294323493804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split into 6 squash-to patches as Paolo suggested.

Geliang Tang (6):
  Squash to "mptcp: add rm_list in mptcp_out_options"
  Squash to "mptcp: add rm_list_tx in mptcp_pm_data"
  Squash to "mptcp: add rm_list in mptcp_options_received"
  Squash to "mptcp: add rm_list_rx in mptcp_pm_data"
  Squash to "mptcp: remove multi subflows in PM"
  Squash to "mptcp: remove multi addresses and subflows in PM"

-- =

2.29.2

--===============0684315294323493804==--
