Content-Type: multipart/mixed; boundary="===============5134669055818299467=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: enable use_port when
 invoke addresses_equal
Date: Thu, 03 Dec 2020 17:57:51 -0800
Message-ID: <b9c3f84-2a7-5696-a84b-c87f1cc5b1f@linux.intel.com>
In-Reply-To: 3c45510c7fadc886e30e528501db5f861539c390.1606733035.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7036

--===============5134669055818299467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 30 Nov 2020, Geliang Tang wrote:

> When dealing with the addresses list local_addr_list or anno_list, we
> should enables the function addresses_equal's parameter use_port.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> The patch should be inserted into the "ADD_ADDR: ports support" patchset
> after the 3rd patch "mptcp: add port number announced check".

Ok, please include in the next revision of that series. Thanks!

> ---
> net/mptcp/pm_netlink.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

--
Mat Martineau
Intel
--===============5134669055818299467==--
