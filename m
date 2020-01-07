Content-Type: multipart/mixed; boundary="===============5549937571728501150=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BPF-related self test failure with part1-v5 patches
Date: Tue, 07 Jan 2020 10:09:49 +0100
Message-ID: <0d09755cf452cd95d31730fef85bc425f429c1a8.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001061427530.8969@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3258

--===============5549937571728501150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 15:05 -0800, Mat Martineau wrote:
> Hello everyone -
> =

> =

> I received a 0day automated build email this morning related to patch 2/1=
1 =

> in our v5 patch set:
> =

> https://lists.01.org/hyperkitty/list/lkp(a)lists.01.org/thread/XB3HTABNGV=
KPJ5QEF46NLIYN6AN5DNGD/
> =

> In summary, there's a test failure in the BPF self tests:
> =

> """
> # selftests: bpf: test_select_reuseport
> ...
> # ######## IPv6/TCP LOOPBACK ########
> # test_err_inner_map: unexpected result
> # result: [0, 0, 0, 1, 0, 0]
> # expected: [1, 0, 0, 0, 0, 0]
> # check_results(343):FAIL:unexpected result expected_results[0] !=3D resu=
lts[0]
> bpf_prog_linum:142
> not ok 17 selftests: bpf: test_select_reuseport # exit=3D255
> """
> =

> It seems like a good idea to see if this is reproducible before sending =

> v6, for a few reasons:

+1

> I run in to build problems, though - it looks like LLVM 10 is required to =

> build the BPF tests, is anyone already set up with that version?

I'm unsure if such version is required, why do you think so?!?

Possibly the issue is related to
bpf_sock_convert_ctx_access()/sock_addr_convert_ctx_access() in
net/core/filter.c

We moved both sk_type and sk_protocol outside of the bitfields, so
likey we must replace *LOAD_SK_FIELD_SIZE_OFF() with something alike
*LOAD_SK_FIELD().

Note: here I'm walking on thin ice, so any additional pair of eyes is
more than welcome!

BTW, happy new year! :)

/P

--===============5549937571728501150==--
