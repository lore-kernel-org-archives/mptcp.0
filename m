Content-Type: multipart/mixed; boundary="===============2610957548295624946=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Correctly handle port field in ADD_ADDR option
Date: Fri, 20 Mar 2020 12:17:26 -0700
Message-ID: <alpine.OSX.2.22.394.2003201216340.19124@mcgray1-mobl.amr.corp.intel.com>
In-Reply-To: 20200320175151.4665-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4033

--===============2610957548295624946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Mar 2020, Peter Krystad wrote:

> Existing code allows ADD_ADDR option lengths that include the port field,
> so we should correctly parse options with those lengths.
>
>
> Peter Krystad (2):
>  mptcp: Parse optional port field of ADD_ADDR
>  mptcp: Include ADD_ADDR port value for path manager
>
> include/linux/tcp.h |  1 +
> net/mptcp/options.c | 11 +++++++++++
> 2 files changed, 12 insertions(+)
>

Both patches look good to me - and they apply cleanly to the current =

export branch.

--
Mat Martineau
Intel
--===============2610957548295624946==--
