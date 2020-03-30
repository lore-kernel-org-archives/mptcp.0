Content-Type: multipart/mixed; boundary="===============3764939598197172047=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/1] selftests:mptcp: fix failure due to
 whitespace damage
Date: Mon, 30 Mar 2020 10:27:46 -0700
Message-ID: <20200330.102746.391267468350272936.davem@davemloft.net>
In-Reply-To: 20200330142354.563259-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4110

--===============3764939598197172047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Mon, 30 Mar 2020 16:23:53 +0200

> But we simply want to ask you this question: Is it normal that these
> trailing whitespaces are automatically removed? We understand if it is
> and it would make sense somehow but just in case it is not normal, we
> prefer to raise the question and avoid other people hitting the same
> issue we had :)

I removed them because "git am" complains when I apply your patches so
I removed them to make git happy.
--===============3764939598197172047==--
