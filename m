Content-Type: multipart/mixed; boundary="===============1265621998605845241=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix stray wake-up event
Date: Tue, 05 Nov 2019 18:39:12 +0100
Message-ID: <d0350d7d-82c7-3f4b-1d84-aea92210508c@tessares.net>
In-Reply-To: alpine.OSX.2.21.1911041546340.10632@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2398

--===============1265621998605845241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 05/11/2019 00:49, Mat Martineau wrote:
> =

> Hi Paolo -
> =

> On Mon, 4 Nov 2019, Paolo Abeni wrote:
> =

>> We always need to set subflow->data_avail after each tcp_read_sock()
>> or mptcp_subflow_recv_lookup() may pick the wrong sock.
> =

> The patch looks good to me, thanks Paolo.

Thank you for the patch and the review!

I just updated the status in https://patchwork.ozlabs.org/patch/1189048/

- e781d6709b06: "squashed" in "mptcp: recvmsg() can drain data from =

multiple subflows"
- signed-off already there
- bb8b1566ac6d..846b30bd664b: results

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1265621998605845241==--
