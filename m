Content-Type: multipart/mixed; boundary="===============8800181350392430015=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] sock diag uAPI and MPTCP
Date: Fri, 19 Jun 2020 12:54:40 +0200
Message-ID: <c5b53444ca4c79b887629c93d954dadbc4a777da.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4747

--===============8800181350392430015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

IPPROTO_MPTCP value (0x106) can't be represented using the current sock
diag uAPI, as the 'sdiag_protocol' field is 8 bits wide.

To implement diag support for MPTCP socket, we will likely need a
'inet_diag_req_v3' with a wider 'sdiag_protocol'
field. inet_diag_handler_cmd() could detect the version of
the inet_diag_req_v* provided by user-space checking nlmsg_len() and
convert _v2 reqs to _v3.

This change will be a bit invasive, as all in kernel diag users will
then operate only on 'inet_diag_req_v3' (many functions' signature
change required), but the code-related changes will be encapsulated
by inet_diag_handler_cmd().

Would the above be acceptable?

Thanks for any feedback!

Paolo

--===============8800181350392430015==--
