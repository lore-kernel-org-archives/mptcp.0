Content-Type: multipart/mixed; boundary="===============2560022661241351427=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 01/16] mptcp: use WRITE_ONCE/READ_ONCE
 for the pernet *_max
Date: Fri, 29 Jan 2021 21:54:00 -0800
Message-ID: <20210129215400.500b63ca@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 20210129011115.133953-2-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7540

--===============2560022661241351427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jan 2021 17:11:00 -0800 Mat Martineau wrote:
> +	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> +		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
> +		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
> +	}

This is an odd construct.

READ_ONCE() is used when the value can change underneath the reader,
not in writers. If we want to increment a variable, there must either
be a writer side lock, or the variable has to be switched to atomic_t.

I'm guessing the former is the case here, so there can be no concurrent
writers. Please omit the READ_ONCE():

	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
		WRITE_ONCE(pernet->add_addr_signal_max, =

			   pernet->add_addr_signal_max + 1);


Same for other 3 cases.
--===============2560022661241351427==--
