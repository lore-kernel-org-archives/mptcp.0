Content-Type: multipart/mixed; boundary="===============0129728990160966161=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix ADD_ADDR HMAC in case port is
 specified
Date: Fri, 12 Mar 2021 16:35:01 -0800
Message-ID: <e982a3ff-26b0-d899-fd35-403d3eb5cf4@linux.intel.com>
In-Reply-To: 74f12b1cf1e60fbfba1b737b8949526346afb983.1615584629.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8129

--===============0129728990160966161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Mar 2021, Davide Caratti wrote:

> Currently, Linux computes the HMAC contained in ADD_ADDR sub-option using
> the Address Id and the IP Address, and hardcodes a destination port equal
> to zero. This is not ok for ADD_ADDR with port: ensure to account for the
> endpoint port when computing the HMAC, in compliance with RFC8684 =C2=A73=
.4.1.
>
> Fixes: 22fb85ffaefb ("mptcp: add port support for ADD_ADDR suboption writ=
ing")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/options.c | 24 ++++++++++++++----------
> 1 file changed, 14 insertions(+), 10 deletions(-)
>

Hi Davide -

Thanks for catching this. Fix looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel

--===============0129728990160966161==--
