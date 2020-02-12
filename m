Content-Type: multipart/mixed; boundary="===============6242681007781831361=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/6] Squash-to: "mptcp: Add path manager
 interface"
Date: Wed, 12 Feb 2020 15:22:43 +0100
Message-ID: <20200212142243.GL2991@breakpoint.cc>
In-Reply-To: d62fdfef647801bac3445fa4f210d4aacc0e5991.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3627

--===============6242681007781831361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> +struct mptcp_pm_data {
> +	struct mptcp_addr_info local;
> +	struct mptcp_addr_info remote;
> +
> +	spinlock_t	lock;
> +
> +	bool		addr_signal;
> +	bool		server_side;
> +	bool		fully_established;
> +	enum mptcp_pm_status status;
> +	u8		add_addr_signaled;
> +	u8		add_addr_accepted;

Why are the first three bool and the rest u8?

We should probably avoid "bool" in structs.
Perhaps use foo:1 as most of net stack?
--===============6242681007781831361==--
