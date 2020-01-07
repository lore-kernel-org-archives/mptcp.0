Content-Type: multipart/mixed; boundary="===============4619517453883398328=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BPF-related self test failure with part1-v5 patches
Date: Tue, 07 Jan 2020 19:13:50 +0100
Message-ID: <99c5be4c85f3f33730b3bd94d27b000e1c8d4006.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001070925080.15534@fepiepan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3268

--===============4619517453883398328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 09:38 -0800, Mat Martineau wrote:
> On Tue, 7 Jan 2020, Paolo Abeni wrote:
> =

> > On Mon, 2020-01-06 at 15:05 -0800, Mat Martineau wrote:
> > > Hello everyone -
> > > =

> > > =

> > > I received a 0day automated build email this morning related to patch=
 2/11
> > > in our v5 patch set:
> > > =

> > > https://lists.01.org/hyperkitty/list/lkp(a)lists.01.org/thread/XB3HTA=
BNGVKPJ5QEF46NLIYN6AN5DNGD/
> > > =

> > > In summary, there's a test failure in the BPF self tests:
> > > =

> > > """
> > > # selftests: bpf: test_select_reuseport
> > > ...
> > > # ######## IPv6/TCP LOOPBACK ########
> > > # test_err_inner_map: unexpected result
> > > # result: [0, 0, 0, 1, 0, 0]
> > > # expected: [1, 0, 0, 0, 0, 0]
> > > # check_results(343):FAIL:unexpected result expected_results[0] !=3D =
results[0]
> > > bpf_prog_linum:142
> > > not ok 17 selftests: bpf: test_select_reuseport # exit=3D255
> > > """
> > > =

> > > It seems like a good idea to see if this is reproducible before sendi=
ng
> > > v6, for a few reasons:
> > =

> > +1
> > =

> > > I run in to build problems, though - it looks like LLVM 10 is require=
d to
> > > build the BPF tests, is anyone already set up with that version?
> > =

> > I'm unsure if such version is required, why do you think so?!?
> =

> My build (LLVM 8) broke on an unknown builtin =

> (__builtin_preserve_access_index), which led me to this thread from =

> September with LLVM version information:
> =

> https://lore.kernel.org/netdev/0a5bf608-bb15-c116-8e58-7224b6c3b62f(a)fb.=
com/
> =

> I'll try skipping the problem builds like you mentioned on IRC.

Running the attached script before 'make clean; make' in the eBPF self-
tests, I'm able to do reproduce successful builds - not sure if it's
luck or some stale 'good' status.

It looks like that deteting files is 'the way' to disable ebpf tests :(

Cheers,

Paolo

p.s. please forgive the incredible ugliness of the script!



--===============4619517453883398328==
Content-Type: application/x-shellscript
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="prepare_ebpf_selftests.sh"

IyEvYmluL3NoCgpmaWxlcz0icHJvZ190ZXN0cy9hdHRhY2hfcHJvYmUuYyBcCnByb2dfdGVzdHMv
Y29yZV9leHRlcm4uYyBcCnByb2dfdGVzdHMvY29yZV9yZWxvYy5jIFwKcHJvZ190ZXN0cy9mZW50
cnlfZmV4aXQuYyBcCnByb2dfdGVzdHMvZmVudHJ5X3Rlc3QuYyBcCnByb2dfdGVzdHMvbW1hcC5j
IFwKcHJvZ190ZXN0cy9za2VsZXRvbi5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2FycmF5cy5j
IFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2FycmF5c19fX2RpZmZfYXJyX2RpbS5jIFwKcHJvZ3Mv
YnRmX19jb3JlX3JlbG9jX2FycmF5c19fX2RpZmZfYXJyX3ZhbF9zei5jIFwKcHJvZ3MvYnRmX19j
b3JlX3JlbG9jX2FycmF5c19fX2VxdWl2X3plcm9fc3pfYXJyLmMgXApwcm9ncy9idGZfX2NvcmVf
cmVsb2NfYXJyYXlzX19fZXJyX2JhZF96ZXJvX3N6X2Fyci5jIFwKcHJvZ3MvYnRmX19jb3JlX3Jl
bG9jX2FycmF5c19fX2Vycl9ub25fYXJyYXkuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19hcnJh
eXNfX19lcnJfdG9vX3NoYWxsb3cuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19hcnJheXNfX19l
cnJfdG9vX3NtYWxsLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfYXJyYXlzX19fZXJyX3dyb25n
X3ZhbF90eXBlLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfYXJyYXlzX19fZml4ZWRfYXJyLmMg
XApwcm9ncy9idGZfX2NvcmVfcmVsb2NfYml0ZmllbGRzLmMgXApwcm9ncy9idGZfX2NvcmVfcmVs
b2NfYml0ZmllbGRzX19fYml0X3N6X2NoYW5nZS5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2Jp
dGZpZWxkc19fX2JpdGZpZWxkX3ZzX2ludC5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2JpdGZp
ZWxkc19fX2Vycl90b29fYmlnX2JpdGZpZWxkLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfYml0
ZmllbGRzX19fanVzdF9iaWdfZW5vdWdoLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfZXhpc3Rl
bmNlLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfZXhpc3RlbmNlX19fZXJyX3dyb25nX2Fycl9r
aW5kLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfZXhpc3RlbmNlX19fZXJyX3dyb25nX2Fycl92
YWx1ZV90eXBlLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfZXhpc3RlbmNlX19fZXJyX3dyb25n
X2ludF9raW5kLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfZXhpc3RlbmNlX19fZXJyX3dyb25n
X2ludF9zei5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2V4aXN0ZW5jZV9fX2Vycl93cm9uZ19p
bnRfdHlwZS5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2V4aXN0ZW5jZV9fX2Vycl93cm9uZ19z
dHJ1Y3RfdHlwZS5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX2V4aXN0ZW5jZV9fX21pbmltYWwu
YyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19mbGF2b3JzLmMgXApwcm9ncy9idGZfX2NvcmVfcmVs
b2NfZmxhdm9yc19fZXJyX3dyb25nX25hbWUuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19pbnRz
LmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfaW50c19fX2Jvb2wuYyBcCnByb2dzL2J0Zl9fY29y
ZV9yZWxvY19pbnRzX19fcmV2ZXJzZV9zaWduLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfbWlz
Yy5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX21vZHMuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxv
Y19tb2RzX19fbW9kX3N3YXAuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19tb2RzX19fdHlwZWRl
ZnMuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19uZXN0aW5nLmMgXApwcm9ncy9idGZfX2NvcmVf
cmVsb2NfbmVzdGluZ19fX2Fub25fZW1iZWQuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19uZXN0
aW5nX19fZHVwX2NvbXBhdF90eXBlcy5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3Rpbmdf
X19lcnJfYXJyYXlfY29udGFpbmVyLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfbmVzdGluZ19f
X2Vycl9hcnJheV9maWVsZC5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3RpbmdfX19lcnJf
ZHVwX2luY29tcGF0X3R5cGVzLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfbmVzdGluZ19fX2Vy
cl9taXNzaW5nX2NvbnRhaW5lci5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3RpbmdfX19l
cnJfbWlzc2luZ19maWVsZC5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3RpbmdfX19lcnJf
bm9uc3RydWN0X2NvbnRhaW5lci5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3RpbmdfX19l
cnJfcGFydGlhbF9tYXRjaF9kdXBzLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfbmVzdGluZ19f
X2Vycl90b29fZGVlcC5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX25lc3RpbmdfX19leHRyYV9u
ZXN0aW5nLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2NfbmVzdGluZ19fX3N0cnVjdF91bmlvbl9t
aXh1cC5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9jX3ByaW1pdGl2ZXMuYyBcCnByb2dzL2J0Zl9f
Y29yZV9yZWxvY19wcmltaXRpdmVzX19fZGlmZl9lbnVtX2RlZi5jIFwKcHJvZ3MvYnRmX19jb3Jl
X3JlbG9jX3ByaW1pdGl2ZXNfX19kaWZmX2Z1bmNfcHJvdG8uYyBcCnByb2dzL2J0Zl9fY29yZV9y
ZWxvY19wcmltaXRpdmVzX19fZGlmZl9wdHJfdHlwZS5jIFwKcHJvZ3MvYnRmX19jb3JlX3JlbG9j
X3ByaW1pdGl2ZXNfX19lcnJfbm9uX2VudW0uYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19wcmlt
aXRpdmVzX19fZXJyX25vbl9pbnQuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19wcmltaXRpdmVz
X19fZXJyX25vbl9wdHIuYyBcCnByb2dzL2J0Zl9fY29yZV9yZWxvY19wdHJfYXNfYXJyLmMgXApw
cm9ncy9idGZfX2NvcmVfcmVsb2NfcHRyX2FzX2Fycl9fX2RpZmZfc3ouYyBcCnByb2dzL2J0Zl9f
Y29yZV9yZWxvY19zaXplLmMgXApwcm9ncy9idGZfX2NvcmVfcmVsb2Nfc2l6ZV9fX2RpZmZfc3ou
YyBcCnByb2dzL2NvcmVfcmVsb2NfdHlwZXMuaApwcm9ncy90ZXN0X2F0dGFjaF9wcm9iZS5jIFwK
cHJvZ3MvdGVzdF9jb3JlX2V4dGVybi5jIFwKcHJvZ3MvdGVzdF9jb3JlX3JlbG9jX2FycmF5cy5j
IFwKcHJvZ3MvdGVzdF9jb3JlX3JlbG9jX2JpdGZpZWxkc19kaXJlY3QuYyBcCnByb2dzL3Rlc3Rf
Y29yZV9yZWxvY19iaXRmaWVsZHNfcHJvYmVkLmMgXApwcm9ncy90ZXN0X2NvcmVfcmVsb2NfZXhp
c3RlbmNlLmMgXApwcm9ncy90ZXN0X2NvcmVfcmVsb2NfZmxhdm9ycy5jIFwKcHJvZ3MvdGVzdF9j
b3JlX3JlbG9jX2ludHMuYyBcCnByb2dzL3Rlc3RfY29yZV9yZWxvY19rZXJuZWwuYyBcCnByb2dz
L3Rlc3RfY29yZV9yZWxvY19taXNjLmMgXApwcm9ncy90ZXN0X2NvcmVfcmVsb2NfbW9kcy5jIFwK
cHJvZ3MvdGVzdF9jb3JlX3JlbG9jX25lc3RpbmcuYyBcCnByb2dzL3Rlc3RfY29yZV9yZWxvY19w
cmltaXRpdmVzLmMgXApwcm9ncy90ZXN0X2NvcmVfcmVsb2NfcHRyX2FzX2Fyci5jIFwKcHJvZ3Mv
dGVzdF9jb3JlX3JlbG9jX3NpemUuYyBcCnByb2dzL3Rlc3Rfc2tlbGV0b24uYyBcCiIKCmZvciBG
IGluICRmaWxlczsgZG8KCWVjaG8gJEYKCXJtIC1mICRGCmRvbmUKCm12IE1ha2VmaWxlIF9NYWtl
ZmlsZQpzZWQgLWUgJ3MvIHRlc3RfY3BwXHMqLy8nIF9NYWtlZmlsZSA+IE1ha2VmaWxlCnJtIC1m
IF9NYWtlZmlsZQo=

--===============4619517453883398328==--
