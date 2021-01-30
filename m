Content-Type: multipart/mixed; boundary="===============8778330561435299809=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 01/16] mptcp: use WRITE_ONCE/READ_ONCE
 for the pernet *_max
Date: Fri, 29 Jan 2021 21:55:44 -0800
Message-ID: <20210129215544.2956c118@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20210129011115.133953-2-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7541

--===============8778330561435299809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jan 2021 17:11:00 -0800 Mat Martineau wrote:
>  	spin_lock_bh(&pernet->lock);
> -	rcv_addrs =3D pernet->add_addr_accept_max;
> +	rcv_addrs =3D READ_ONCE(pernet->add_addr_accept_max);

Oh, this reader is also under the lock, what's the concurrency issue
you speak of?
--===============8778330561435299809==--
