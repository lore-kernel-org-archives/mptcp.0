Content-Type: multipart/mixed; boundary="===============6205910002541175472=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 0/6] mptcp: avoid passing
 rm_list as a struct
Date: Sat, 06 Mar 2021 09:58:47 +0100
Message-ID: <8b9c320b-e095-280e-452b-e5dbad946b76@tessares.net>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8059

--===============6205910002541175472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 04/03/2021 07:42, Geliang Tang wrote:
> Split into 6 squash-to patches as Paolo suggested.
> =

> Geliang Tang (6):
>    Squash to "mptcp: add rm_list in mptcp_out_options"
>    Squash to "mptcp: add rm_list_tx in mptcp_pm_data"
>    Squash to "mptcp: add rm_list in mptcp_options_received"
>    Squash to "mptcp: add rm_list_rx in mptcp_pm_data"
>    Squash to "mptcp: remove multi subflows in PM"
>    Squash to "mptcp: remove multi addresses and subflows in PM"

Thank you for these patches and review!

- b9985d924015: "squashed" patch 1/6 in "mptcp: add rm_list in =

mptcp_out_options"
- 15f713ee5257: "squashed" patch 2/6 in "mptcp: add rm_list_tx in =

mptcp_pm_data"
- 9bbec2f8dccd: "squashed" patch 3/6 in "mptcp: add rm_list in =

mptcp_options_received"
- 33f3492800e3: conflict in t/mptcp-add-rm_list_rx-in-mptcp_pm_data
- b7b6189037d6: "squashed" patch 4/6 in "mptcp: add rm_list_rx in =

mptcp_pm_data"
- a741d28da559: conflict in t/mptcp-remove-multi-subflows-in-PM
- 0707c761b750: "squashed" patch 5/6 in "mptcp: remove multi subflows in PM"
- 10b536ddc721: "squashed" patch 6/6 in "mptcp: remove multi addresses =

and subflows in PM"
- Results: d5316810240e..20b4296239fa

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6205910002541175472==--
