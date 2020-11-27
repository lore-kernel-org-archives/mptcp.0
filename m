Content-Type: multipart/mixed; boundary="===============8389698827224588055=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] force existing service to use MPTCP
Date: Fri, 27 Nov 2020 19:43:36 +0100
Message-ID: <d3a06454529b77757dc27b7157b3f55fee8f25b3.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6967

--===============8389698827224588055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello,

reviving this old topic.

I've experimented a bit with the LD_PRELOAD thing.

Looks like at least nginx and apache can be forced to use MPTCP instead
of TCP with a crafted unit file created automatically from the distro-
provided one.

e.g. for nginx, adding:

Conflicts=3Dnginx.service
After=3Dnginx.service

into the [unit] section, and:

Environment=3D"LD_PRELOAD=3D/usr/lib64/use_mptcp.so"
ExecStartPre=3Dsysctl -w net.mptcp.enabled=3D1

into the [Service] section.

Then I had to fight a bit with selinux. I did not really investigate
the issue, I think/fear selinux misunderstood mptcp sockets as raw
ones, so default policy fails. A bunch of:

ausearch -c 'nginx' --raw | audit2allow -M my-nginx
semodule -i my-nginx.pp

solved the problem.

Bottom line:
- the above looks tecnically viable [at least for some services]. I'm
looking for a more extended service/daemon list to investigate
fourther. I think we could/should really consider package the above in
mptcpd or the like.
- selinux (surprise, surprise!) can be a problem. Worth looking at it
(that is independent from the system we will pick to force MPTCP socket
usage)

Cheers,

Paolo

--===============8389698827224588055==--
