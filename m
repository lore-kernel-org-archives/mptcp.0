Content-Type: multipart/mixed; boundary="===============0977811310966262738=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] net-next currently broken ?!?
Date: Tue, 19 Jan 2021 00:06:59 +0100
Message-ID: <eb713663eac1d8867586cc7b71fe5c3072f52101.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7417

--===============0977811310966262738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(or it's just me lacking coffee?!?)

I just tried plain net-next at

commit 213b97b125808aa220ba460a7af09d8f3772f669
Merge: 20efd2c79afb 1fef8544bf41
Author: Jakub Kicinski <kuba(a)kernel.org>
Date:   Sat Jan 16 19:06:01 2021 -0800

    Merge branch 'net-fix-the-features-flag-in-sctp_gso_segment'

selftests mptcp_connect.sh randomly fail with data corruption: the
amount of transferred data is correct, the fail contains some chunk of
random data.

Can anybody else replicate the above?

Thanks,

Paolo

--===============0977811310966262738==--
