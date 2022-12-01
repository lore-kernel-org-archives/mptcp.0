Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F62F5F
	for <mptcp@lists.linux.dev>; Thu,  1 Dec 2022 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669902160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JFmfYM5LoXA563qdj8y1YLMTKUtP2pIqcacn/YOGYUU=;
	b=U9HbsnM425NA35+i5DTo5FdzpysCLbFL0SuwX3Gm8aY9hOcpsKPAyEUSeFcUg7FHvqCMjG
	pa0T+AyV6AOz47o76KwLgVF12s4f8Pb6yEiKfhe6GtlVd/z5BSd7r52MkuN/W7pc60WkBU
	uYdsZOh3Zriw9MlZiLs/f9+uOYi+gBo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-o-E4AGwlOtOBDyEpcGQGGw-1; Thu, 01 Dec 2022 08:42:39 -0500
X-MC-Unique: o-E4AGwlOtOBDyEpcGQGGw-1
Received: by mail-pl1-f198.google.com with SMTP id m1-20020a170902db0100b00188eec2726cso2340354plx.18
        for <mptcp@lists.linux.dev>; Thu, 01 Dec 2022 05:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFmfYM5LoXA563qdj8y1YLMTKUtP2pIqcacn/YOGYUU=;
        b=z9rN1ZEsdfDVzSgad92Jz2Y/G1N+YDqi7GqfbIUmBUwhnc2vLSNfnQTYEcqnL9RVy1
         1pD/IDXxlzVggqkV8NG85tovXItgz0j/4fPOisw8ZkY7GJ1TNCKxc+kZK56kxJ+NMiIB
         7ytOo72Dgtzq8Oarh35h1wIjm2C8M0Hl7fV2vOhXrDHuLvXjYsxFHhPtIIyx7isNYKsg
         75t4VMf0rbFfdztofgcxXnVWbbVenOtZ7O7B+rH6Gk7VeTMjFdMAHPKFgypi9kMrZMM/
         qXwO1sReoE2GeSzgc3yJN3IK9UG8s+1sqNo/DOJi02VTsSx1/iwUxAGROhoUQ9sBA/Nv
         BzAg==
X-Gm-Message-State: ANoB5plJZ8i1/XIlI/rMxUSI9oM74/kGAbEXMv9mOlxGRKWlfyVmagSV
	ey+YnoQmz90noO9QLnSEreNP/bcp6A4inGGk5pRYLIZtWgwXRFvE7grq1IgSC3KAn0mI+uvccTD
	T0Xdk5OCjR8yHj0YgcbFifkBAcrJ6860=
X-Received: by 2002:a63:d256:0:b0:478:46b4:4f91 with SMTP id t22-20020a63d256000000b0047846b44f91mr10734505pgi.211.1669902158402;
        Thu, 01 Dec 2022 05:42:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7hfeI7JUFKW7r1yZwl9mS4lZxu7yY2ud+HorSjVux0lDFkOojpYVtssDT4W17zipH8gTMB1qFgxhhonWp3lEs=
X-Received: by 2002:a63:d256:0:b0:478:46b4:4f91 with SMTP id
 t22-20020a63d256000000b0047846b44f91mr10734488pgi.211.1669902158147; Thu, 01
 Dec 2022 05:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 1 Dec 2022 14:42:27 +0100
Message-ID: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
Subject: Broken SELinux/LSM labeling with MPTCP and accept(2)
To: SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev
Cc: network dev <netdev@vger.kernel.org>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Paul Moore <paul@paul-moore.com>, 
	Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

As discovered by our QE, there is a problem with how the
(userspace-facing) sockets returned by accept(2) are labeled when
using MPTCP. Currently they always end up with the label representing
the kernel (typically system_u:system_r:kernel_t:s0), white they
should inherit the context from the parent socket (the one that is
passed to accept(2)).

A minimal reproducer on a Fedora/CentOS/RHEL system:

# Install dependencies
dnf install -y mptcpd nginx curl
# Disable rules that silence some SELinux denials
semodule -DB
# Set up a dummy file to be served by nginx
echo test > /usr/share/nginx/html/testfile
chmod +r /usr/share/nginx/html/testfile
# Set up nginx to use MPTCP
sysctl -w net.mptcp.enabled=1
systemctl stop nginx
mptcpize enable nginx
systemctl start nginx
# This will fail (no reply from server)
mptcpize run curl -k -o /dev/null http://127.0.0.1/testfile
# This will show the SELinux denial that caused the failure
ausearch -i -m avc | grep httpd

It is also possible to trigger the issue by running the
selinux-testsuite [1] under `mptcpize run` (it will fail on the
inet_socket test in multiple places).

Based on what I could infer from the net & mptcp code, this is roughly
how it happens (may be inaccurate or incorrect - the maze of the
networking stack is not easy to navigate for me):
1. When the server starts, the main mptcp socket is created:
   socket(2) -> ... -> socket_create() -> inet_create() ->
mptcp_init_sock() -> __mptcp_socket_create()
2. __mptcp_socket_create() calls mptcp_subflow_create_socket(), which
creates another "kern" socket, which represents the initial(?)
subflow.
3. This subflow socket goes through security_socket_post_create() ->
selinux_socket_post_create(), which gives it a kernel label based on
kern == 1, which indicates that it's a kernel-internal socket.
4. The main socket goes through its own selinux_socket_post_create(),
which gives it the label based on the current task.
5. Later, when the client connection is accepted via accept(2) on the
main socket, an underlying accept operation is performed on the
subflow socket, which is then returned directly as the result of the
accept(2) syscall.
6. Since this socket is cloned from the subflow socket, it inherits
the kernel label from the original subflow socket (via
selinux_inet_conn_request() and selinux_inet_csk_clone()).
selinux_sock_graft() then also copies the label onto the inode
representing the socket.
7. When nginx later calls writev(2) on the new socket,
selinux_file_permission() uses the inode label as the target in a
tcp_socket::write permission check. This is denied, as in the Fedora
policy httpd_t isn't allowed to write to kernel_t TCP sockets.

Side note: There is currently an odd conditional in sock_has_perm() in
security/selinux/hooks.c that skips SELinux permission checking for
sockets that have the kernel label, so native socket operations (such
as recv(2), send(2), recvmsg(2), ...) will not uncover this problem,
only generic file operations such as read(2), write(2), writev(2),
etc. I believe that check shouldn't be there, but that's for another
discussion...

So now the big question is: How to fix this? I can think of several
possible solutions, but neither of them seems to be the obvious
correct one:
1. Wrap the socket cloned from the subflow socket in another socket
(similar to how the main socket + subflow(s) are handled), which would
be cloned from the non-kern outer socket that has the right label.
This could have the disadvantage of adding unnecessary overhead, but
would probably be simpler to do.
2. Somehow ensure that the cloned socket gets the label from the main
socket instead of the subflow socket. This would probably require
adding a new LSM hook and I'm not sure at all what would be the best
way to implement this.
3. Somehow communicate the subflow socket <-> main socket relationship
to the LSM layer so that it can switch to use the label of the main
socket when handling an operation on a subflow socket (thus copying
the label correctly on accept(2)). Not a great solution, as it
requires each LSM that labels sockets to duplicate the indirection
logic.
4. Do not create the subflow sockets as "kern". (Not sure if that
would be desirable.)
5. Stop labeling kern sockets with the kernel's label on the SELinux
side and just label them based on the current task as usual. (This
would probably cause other issues, but maybe not...)

Any ideas, suggestions, or patches welcome!

[1] https://github.com/SELinuxProject/selinux-testsuite/

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

