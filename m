Content-Type: multipart/mixed; boundary="===============1668502767034834544=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 01/13] mptcp: more DATA FIN fixes
Date: Fri, 02 Oct 2020 16:14:25 -0700
Message-ID: <alpine.OSX.2.23.453.2010021613580.58928@huizhan1-mobl1.amr.corp.intel.com>
In-Reply-To: 6f72ee7f926a7fb06a9000084ef2a99154786f47.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6174

--===============1668502767034834544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 2 Oct 2020, Paolo Abeni wrote:

> Currently data fin on data packet are not handled properly:
> the 'rcv_data_fin_seq' field is interpreted as the last
> sequence number carrying a valid data, but for data fin
> packet with valid maps we currently store map_seq + map_len,
> that is, the next value.
>
> The 'write_seq' fields carries instead the value subseguent
> to the last valid byte, so in mptcp_write_data_fin() we
> never detect correctly the last DSS map.
>
> Fixes: f7b6e548510a ("mptcp: Handle incoming 32-bit DATA_FIN values")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c | 10 +++++-----
> net/mptcp/subflow.c |  2 +-
> 2 files changed, 6 insertions(+), 6 deletions(-)
>

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1668502767034834544==--
