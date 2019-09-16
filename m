Content-Type: multipart/mixed; boundary="===============2855004721123718909=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to
 userspace
Date: Mon, 16 Sep 2019 15:00:58 +0200
Message-ID: <63a02d53ce0099573b661fd4d2e4fdba3f41953f.camel@redhat.com>
In-Reply-To: 20190914100902.GH10656@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1849

--===============2855004721123718909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Florian,

this is the kind of feedback I needed, thanks a lot for looking at this.

On Sat, 2019-09-14 at 12:09 +0200, Florian Westphal wrote:
> Davide Caratti <dcaratti(a)redhat.com> wrote:
> > On Thu, 2019-09-12 at 18:50 +0200, Davide Caratti wrote:
[...]
> > This patch exposes token, local/remote
> > keys, and some of the bitfield members. What do you think it's reasonab=
le
> > exposing to users of 'ss -i' ?
> =

> The MPTCP (parent/meta) socket data, e.g. the DSS would be good.
> Once Paolo retrans is in, we could also extend that to expose
> information about MPTCP-Level events (rather than subflow stats).
> This is a great start though.  I guess it might be good to expose
> how much more data the current mapping expects.

I'm a bit reluctant on using ulp_diags to dump data that are specific to
the "master socket": when the number of subflows becomes high, this
results in unneeded copies of the same information that are passed from
kernel to userspace.

It would be much better if msk-related information are obtained by another
piece of code (that does not exist yet) that walks the token tree,
extracts msk-related info and dumps it to userspace, e.g. when 'ss' is
called with a new command line argument (something like 'ss -M').

For subflows, the only msk-specific information that's worth being part of
dump is the value of 'token', so we can use it on a live system to know
which MPTCP connection is using a given TCP socket, or if two (or more)
sockets belong to the same MPTCP connection.

> Wrt. local/remote keys, what is the use case?

my use case was assessing the correct exchange for the first 3WHS. But,
good point, also local/remote key are specific to the MSK: we don't need
them in the subflow dump.

> I'm asking because some people get nervous when you add an api to
> expose 'secret keys'.
> =

> If there is no clear use-case i'd rather not expose them for now,
> it can be added later if needed.

since local/rempte keys travelled in cleartext over the internet during
the first 3WHS, I wouldn't say they are a real secret. And then someone of
those "nervous" guys would argue anyway why we are storing them at memory
locations that have a constant offset from the subflow (and master
socket), and why we don't explicitly clear them when a subflow ends(*). =

But, I agree with you we don't need to dump these two numbers here, they
are more part of the "MPTCP control block" (**).

back to the topic, please find below a proposal of subflow-related infos:

- token
- rel_write_seq
- idsn
- map_seq
- map_subflow_seq (*)
- ssn_offset
- map_data_len (*)
- flags (all fields except 'request_version')
- local_id
- remote_id

WDYT?

-- =

davide


(*) e.g. what was done in kTLS with commits c844eb46b7d ("tls: clear key
material from kernel memory when do_tls_setsockopt_conf fails") and
86029d10af18 ("tls: zero the crypto information from tls_context before
freeing"). =

(**) like defined in https://tools.ietf.org/html/rfc6824#appendix-B


--===============2855004721123718909==--
