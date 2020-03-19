Content-Type: multipart/mixed; boundary="===============4403111901815909411=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Additional part 3 squash suggestion
Date: Thu, 19 Mar 2020 16:24:18 -0700
Message-ID: <alpine.OSX.2.22.394.2003191614420.3820@sugandh1-mobl2.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3999

--===============4403111901815909411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Florian and Matthieu -

From the meeting notes, it looks like "subflow: place further subflows on =

new 'join_list'" is the commit that you're planning to squash.

What do you think about also squashing "mptcp: increment MIB counters in a =

few places" in to the previous MIB commit? Seems like our patch count for =

part 3 is still kind of high.

--
Mat Martineau
Intel
--===============4403111901815909411==--
