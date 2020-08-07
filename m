Content-Type: multipart/mixed; boundary="===============1106942651937286975=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix warn at shutdown time for
 unaccepted msk sockets
Date: Fri, 07 Aug 2020 19:48:47 +0200
Message-ID: <56686a4e-bc24-b247-1a57-260db329c651@tessares.net>
In-Reply-To: 2458c1210f1a164c615e3aa3b9613b085a6c8326.1596819537.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5517

--===============1106942651937286975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 07/08/2020 19:03, Paolo Abeni wrote:
> With commit b93df08ccda3 ("mptcp: explicitly track the fully
> established status"), the status of unaccepted mptcp closed in
> mptcp_sock_destruct() changes from TCP_SYN_RECV to TCP_ESTABLISHED.
> =

> As a result mptcp_sock_destruct() does not perform the proper
> cleanup and inet_sock_destruct() will later emit a warn.
> =

> Address the issue updating the condition tested in mptcp_sock_destruct().
> Also update the related comment.

Thank you for this new patch!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1106942651937286975==--
