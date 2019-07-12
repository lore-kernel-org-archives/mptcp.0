Content-Type: multipart/mixed; boundary="===============8635229961564529436=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: fix .gitignore for mptcp
 selftests
Date: Fri, 12 Jul 2019 10:33:26 +0200
Message-ID: <edd40a2d-b5d4-504e-41e7-6741addf6064@tessares.net>
In-Reply-To: a36b8c52f786894a6595e214a6449ffa021e34b2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1491

--===============8635229961564529436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 11/07/2019 18:49, Davide Caratti wrote:
> On Thu, 2019-07-11 at 18:44 +0200, Davide Caratti wrote:
>> since mptcp_connect.sh can generate pcap traces when the '-c' argument is
>> used, add *.pcap to .gitignore, to avoid untracked files in the output of
>> "git status".
>>
>>  [root(a)rhel7 mptcp]# git status
>>  # HEAD detached at origin/mptcp-prova
>>  # Untracked files:
>>  #   (use "git add <file>..." to include in what will be committed)
>>  #
>>  #       ns1-ns1-MPTCP-MPTCP-10.0.1.1.pcap
>>  #       ns1-ns1-MPTCP-TCP-10.0.1.1.pcap
>>  #       ns1-ns1-TCP-MPTCP-10.0.1.1.pcap
>>  [...]
>>
>> Fixes: 4dc10c542166 ("mptcp: selftests: Add capture option")
> =

> I forgot to mention the proposal to squash this in the above commit :)

Thank you for the patch, good catch!

Just applied:
- f695b6271a17: "squashed" in "mptcp: selftests: Add capture option"
- a42e1d875914: signed-off
- 22126216e094..427cd6baacec: results

Tests are in progress... just for the fun :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8635229961564529436==--
