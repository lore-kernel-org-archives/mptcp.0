Content-Type: multipart/mixed; boundary="===============1197805566446559214=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Fix bug processing options
Date: Fri, 25 Oct 2019 16:40:40 -0700
Message-ID: <alpine.OSX.2.21.1910251640160.66912@srpullel-mobl.amr.corp.intel.com>
In-Reply-To: 20191022225459.15312-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2329

--===============1197805566446559214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 22 Oct 2019, Peter Krystad wrote:

> Do not process incoming options if the subflow is not MPTCP.
>
> Observed crash when running against out-of-tree kernel with
> mis-matched checksum options.
>
> Peter Krystad (2):
>  mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>  mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>
> net/mptcp/options.c | 3 +++
> 1 file changed, 3 insertions(+)
>

Both changes look good to me. Thanks, Peter!

--
Mat Martineau
Intel
--===============1197805566446559214==--
