Content-Type: multipart/mixed; boundary="===============4896626339816306128=="
MIME-Version: 1.0
From: Song Liu <song at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next v2 2/5] mptcp: attach subflow socket to
 parent cgroup
Date: Mon, 14 Sep 2020 13:52:24 -0700
Message-ID: <CAPhsuW4xqPD641gHAs7GjhmW7SANMhz75VKbP02Xyja9CnpZ-g@mail.gmail.com>
In-Reply-To: 20200911143022.414783-2-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5862

--===============4896626339816306128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 9:43 AM Nicolas Rybowski
<nicolas.rybowski(a)tessares.net> wrote:
>
> It has been observed that the kernel sockets created for the subflows
> (except the first one) are not in the same cgroup as their parents.
> That's because the additional subflows are created by kernel workers.
>
> This is a problem with eBPF programs attached to the parent's
> cgroup won't be executed for the children. But also with any other featur=
es
> of CGroup linked to a sk.
>
> This patch fixes this behaviour.
>
> As the subflow sockets are created by the kernel, we can't use
> 'mem_cgroup_sk_alloc' because of the current context being the one of the
> kworker. This is why we have to do low level memcg manipulation, if
> required.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>

Acked-by: Song Liu <songliubraving(a)fb.com>

[...]
--===============4896626339816306128==--
