Content-Type: multipart/mixed; boundary="===============6451710906611204935=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: fix .gitignore for mptcp
 selftests
Date: Thu, 11 Jul 2019 18:49:19 +0200
Message-ID: <a36b8c52f786894a6595e214a6449ffa021e34b2.camel@redhat.com>
In-Reply-To: 3dc9dce8f6705744193d46d72786fc2caa1f2da6.1562863484.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1485

--===============6451710906611204935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-11 at 18:44 +0200, Davide Caratti wrote:
> since mptcp_connect.sh can generate pcap traces when the '-c' argument is
> used, add *.pcap to .gitignore, to avoid untracked files in the output of
> "git status".
> =

>  [root(a)rhel7 mptcp]# git status
>  # HEAD detached at origin/mptcp-prova
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
>  #
>  #       ns1-ns1-MPTCP-MPTCP-10.0.1.1.pcap
>  #       ns1-ns1-MPTCP-TCP-10.0.1.1.pcap
>  #       ns1-ns1-TCP-MPTCP-10.0.1.1.pcap
>  [...]
> =

> Fixes: 4dc10c542166 ("mptcp: selftests: Add capture option")

I forgot to mention the proposal to squash this in the above commit :)

thanks!
-- =

davide



--===============6451710906611204935==--
