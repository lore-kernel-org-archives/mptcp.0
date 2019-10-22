Content-Type: multipart/mixed; boundary="===============8024618545899220924=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests:mptcp: increase timeout
Date: Tue, 22 Oct 2019 22:24:19 +0200
Message-ID: <20191022202419.GK25052@breakpoint.cc>
In-Reply-To: 20191022170657.20129-3-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2266

--===============8024618545899220924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> +time_end=3D$(date +%s)
> +tiem_run=3D$((time_end-time_start))
   ^^^^^^^

Ahem...  Other than that, this looks good, thanks.
--===============8024618545899220924==--
