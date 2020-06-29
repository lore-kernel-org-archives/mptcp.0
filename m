Content-Type: multipart/mixed; boundary="===============6492736645078762606=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "net: mptcp: improve fallback to TCP"
Date: Mon, 29 Jun 2020 14:39:59 +0200
Message-ID: <4709d8817dd8a82360105ed31840ee7a429df613.camel@redhat.com>
In-Reply-To: cd2d13dd-bce6-02df-6cc8-8e80605888b3@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4843

--===============6492736645078762606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-06-27 at 09:50 +0200, Matthieu Baerts wrote:
> Tests are still OK (except the issue with Packetdrill)

hello,

FYI: the issue with packetdrill has been narrowed down to this commit:

commit e9c15badbb7b20ccdbadf5da14e0a68fbad51015
Author: Mel Gorman <mgorman(a)techsingularity.net>
Date:   Mon Jun 15 13:13:58 2020 +0100

    fs: Do not check if there is a fsnotify watcher on pseudo inodes

with this commit, all tests starting with lines like the following one,

0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
0.1 fcntl(3, F_GETFL) =3D 0x2 (flags O_RDWR)

are going to fail, regardless of the the value of 'protocol' in the call
to socket(family, type, protocol). The call to fcntl() will return O_RDWR
| O_NOATIME (that is 0x4000002, insted of just O_RDWR, hence the failure
below:

# cat prova.pkt
0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+0 fcntl(3, F_GETFL) =3D 0x2 (flags O_RDWR)
# ./packetdrill -vvv ./prova.pkt
socket syscall: 1593425866.359845
fcntl syscall: 1593425866.359899
./prova.pkt:2: runtime error in fcntl call: Expected result 2 but got 67108=
866 with errno 2 (No such file or directory)

(where 67108866 -> 0x4000002 -> O_RDWR | O_NOATIME).

the problem is common to all tests (both TCP and MPTCP). If we want to fix
this, we should not expect fcntl() to return a scalar value, but we should
accept all return values matching a bitmask.

Do you think it's worth a question to the official packetdrill mailing
list?

any feedback appreciated, thank you in advance!
-- =

davide

--===============6492736645078762606==--
