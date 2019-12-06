Content-Type: multipart/mixed; boundary="===============5768753283240739497=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove dss_flags field from struct
 mptcp_options_received
Date: Fri, 06 Dec 2019 09:33:18 +0100
Message-ID: <24d18761a7d6bcd40ee9dcaa1672d182d01cc454.camel@redhat.com>
In-Reply-To: 20191205234358.27455-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2809

--===============5768753283240739497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-05 at 15:43 -0800, Peter Krystad wrote:
> This field is used only temporarily while parsing options,
> use a local variable instead.
> =

> Formatted to apply directly to Implement MPTCP receive path.
> =

> squashto: Implement MPTCP receive path
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

LGTM.

Acked-by: Davide Caratti <dcaratti(a)redhat.com>


--===============5768753283240739497==--
